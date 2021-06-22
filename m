Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314923AFFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhFVJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:02:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35866 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhFVJC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:02:57 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D6B721979;
        Tue, 22 Jun 2021 09:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624352441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V+Xfmg830M8n9+NrGvjN1kAkN+UzXsHn+02ZmDZXAr8=;
        b=l5wGVvIRpo+MtTgGMhelsna64GlwJx6X5SH9jxAhQ9UdJzKQcigUmYzLiXkwbaL2trQ4Fk
        7Vscq2Qrm6QyuYWQIFl08YfgJRtquAdK838s3veN1ha2paW9b25u3wZdtFobzL1f6OUxMj
        xz4Zw06StoyekixY8Sn1sTVE7PLctz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624352441;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V+Xfmg830M8n9+NrGvjN1kAkN+UzXsHn+02ZmDZXAr8=;
        b=RN2zPWA7ynSy5mQN/EfY1CRCAW3DdCMXu0jRwRpgcyDpN7rh4stzWphV5ApTXqoG/V/5q8
        nPUBdKMRIwpDu/AQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 50E88118DD;
        Tue, 22 Jun 2021 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624352441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V+Xfmg830M8n9+NrGvjN1kAkN+UzXsHn+02ZmDZXAr8=;
        b=l5wGVvIRpo+MtTgGMhelsna64GlwJx6X5SH9jxAhQ9UdJzKQcigUmYzLiXkwbaL2trQ4Fk
        7Vscq2Qrm6QyuYWQIFl08YfgJRtquAdK838s3veN1ha2paW9b25u3wZdtFobzL1f6OUxMj
        xz4Zw06StoyekixY8Sn1sTVE7PLctz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624352441;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V+Xfmg830M8n9+NrGvjN1kAkN+UzXsHn+02ZmDZXAr8=;
        b=RN2zPWA7ynSy5mQN/EfY1CRCAW3DdCMXu0jRwRpgcyDpN7rh4stzWphV5ApTXqoG/V/5q8
        nPUBdKMRIwpDu/AQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id LsSwD7im0WB2HAAALh3uQQ
        (envelope-from <osalvador@suse.de>); Tue, 22 Jun 2021 09:00:40 +0000
Date:   Tue, 22 Jun 2021 11:00:38 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        dan.j.williams@intel.com, david@redhat.com, weixugc@google.com,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V8 00/10] Migrate Pages in lieu of discard
Message-ID: <20210622090033.GA11045@linux>
References: <20210618061537.434999-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618061537.434999-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 02:15:27PM +0800, Huang Ying wrote:
> The full series is also available here:
> 
> 	https://github.com/hying-caritas/linux/tree/automigrate-20210618
> 
> The changes since the last post are as follows,
> 
>  * Change the page allocation flags per Michal's comments.
>  * Change the user interface to enable the feature.

Hi Huang Ying,

I would suggest going back to [1] and revisit the feedback provided in v7,
as it seemed you ignored (probably not intentionally) some of the provided
comments.

Thanks

-- 
Oscar Salvador
SUSE L3
