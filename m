Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120C7342E68
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCTQgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 12:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhCTQgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 12:36:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EDDC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y6ev/S60/HNebOaHyGgfUCQe+A2W0+aqw6QjjL6rHiI=; b=V9/+VJy40SYLUA9lxHDjTtaoWm
        51s+AiknwRUhKVkLlyX/mjHwB1emhYm7p+6yHYXtLcr/d4VmYh1u+iEthlH2nb8QV3yFqFvtw3ru3
        JMaPLZjOHPZdYr1uS2Bk9LSNyH7pi/Po2LREx4QuAOtjMK0XxQ95UmB+qjROqFX669p0hNlho8piv
        7yzHo4x09XfexhTd2/79CDt11wlXjGxT/CPeZ4rFiZfYgaBJ/fz9IWY+8PPvBzkcwBbw6Wi1BhScY
        Fqw+kChcdO5NSiyYRDcfI5s0ONdi2lqaOuzgi1hVGRDr8+ru3kp6CjkgxIoV1BrOprfqwSNzRd5CS
        DvQFVHlg==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNeZs-001wGD-4D; Sat, 20 Mar 2021 16:35:53 +0000
Date:   Sat, 20 Mar 2021 09:35:52 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Aditya Srivastava <yashsri421@gmail.com>
cc:     anton@tuxera.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix incorrect kernel-doc comment syntax in files
In-Reply-To: <20210320162939.32707-1-yashsri421@gmail.com>
Message-ID: <e583cfe6-6b79-c35f-3bf7-2b47f7ee52be@bombadil.infradead.org>
References: <20210320162939.32707-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_093552_188116_09A1E9CA 
X-CRM114-Status: UNSURE (   2.10  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  LGTM. Thanks. Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


