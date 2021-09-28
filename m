Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C6741AFB7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbhI1NQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbhI1NQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:38 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE6AC061765
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:14:57 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 83C607082; Tue, 28 Sep 2021 15:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valentin-vidic.from.hr; s=2020; t=1632834890;
        bh=E/0LxL09bBY2fiszU3Kyogy3/Dubx8Z6W0IGTU1w+wU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5WVQ6kuWAvSpaL2j7nRovvJjUUAG6BtaXClM7Dn58/9sS17Raii0mbl338r98UMe
         KJBIqsYPGQPqXrqEUBUNH7SFAcBQZyYZ+xxCcVtI2SzOgUrui85z2pHVCYGLD/PvN1
         7BDq+EtqtyILmlaG3AX52CHgB9Onm9FWAuxZsDr+4hbnwrge5HUQIUgbCaskDs2J7B
         E6dcM9BEr6AyAESk7+GSaUtdSOUF2KAOz9CEfdgj4QqDihptMQzSuC5CxInz3V3sLi
         0drRQr+0ZoolPwxXP/HCdYCZmUFgZML1eur4GDqCMpRK0CRMSERlPA9lwb2VWfnWYF
         C49QZGFqREGsXR6/NiX4EfBF1RqayWuptYY4D1jVcMCiagxFB+A7F556JE9xKdU6CY
         MbO+WHEWV9c6q59rbMMoa+YYDAw8ATZCBw/F8+9jZuusKuJq3UueSqz65jYP1jLfHJ
         73r7//uaIO70C0hCC9cmD+oe40RZkdsJb32AuMuMhjXHsteLUTQfa199ERsLSAUxXv
         JEF9WwLy7xkmTOn3/dixDe4aiPPD/FIbSf1Ad4tFBmVyWQOzGdQSblpriUSwn9Kls3
         iZTtJAMvGlUFR/j39/sUPnPi3FV7sLfMfeeCBPeVAwCFtMpjdvBubEPOcS2qhw5qNf
         gzmsuoaWKPKIzU/ARq6kxgNE=
Date:   Tue, 28 Sep 2021 15:14:50 +0200
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ocfs2: mount fails with buffer overflow in strlen
Message-ID: <20210928131450.GM28341@valentin-vidic.from.hr>
References: <20210927154459.15976-1-vvidic@valentin-vidic.from.hr>
 <00850aed-2027-a0ab-e801-c6498a5a49f8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00850aed-2027-a0ab-e801-c6498a5a49f8@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:05:22PM +0800, Joseph Qi wrote:
> strlcpy in ocfs2_initialize_super() is introduced 8 years ago, so I
> don't understand why you've mentioned that the issues starts from
> v5.11.

v5.11 introduced the overflow checks to string functions so that is
when the mount started to fail.

> osb->osb_cluster_stack and osb->osb_cluster_name is always larger by
> 1 than which in ocfs2_cluster_info, and the input size of strlcpy does
> the same, so I don't see how it overflows.

strlcpy internally calls strlen on the source argument, in this case
that is ci_stack array with size of 4. That array stores the value
"o2cb" so the strlen continues reading into the union until it reaches
a zero byte somewhere. The same would happen with ci_cluster if the
cluster name is long enough.

struct ocfs2_cluster_info {
/*00*/	__u8   ci_stack[OCFS2_STACK_LABEL_LEN];
	union {
		__le32 ci_reserved;
		struct {
			__u8 ci_stackflags;
			__u8 ci_reserved1;
			__u8 ci_reserved2;
			__u8 ci_reserved3;
		};
	};
/*08*/	__u8   ci_cluster[OCFS2_CLUSTER_NAME_LEN];
/*18*/
};

-- 
Valentin
