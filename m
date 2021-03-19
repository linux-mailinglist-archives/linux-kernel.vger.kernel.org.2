Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79A43423ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhCSSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCSSBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:01:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7F5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uTbl6guFGQdbk49aLzrQbkLTdEFuonclJgyelza8jbk=; b=d3OkbniiKP81FNhFe250Q1Xy/w
        a0ncQuxQh8iqQ+mczYZmDh6TYKd9WSPWTJ9AyE1rOJ3TeCtQ9vDGoc2T724Fe0bO+s+7fjTL7Bu+U
        T3YksTt8b941mtSXCKFIqHSCEXrjbY10TH3mSlg/QqPl7GuKWDOtz8oYZJxA6uexrOnfwPXq69h9V
        myOOeq9ki410yQLr0kNOkIE0oQehxsnv7Mg6JQMW/3P/krEiIrW+1GXBuI09ymLdp1XulLoejOh6w
        phyZ29twDr1qQ3yhIpSwHJ7uXQtmOE/bjDZQnApKFPmciXTTQCOdi16JLNDT+oRRiseZLcvnbCaXz
        e8MmVMAA==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNJRI-001RNk-BN; Fri, 19 Mar 2021 18:01:37 +0000
Date:   Fri, 19 Mar 2021 11:01:36 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     hirofumi@mail.parknet.co.jp, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: Fix a mundane typo
In-Reply-To: <20210319015848.19515-1-unixbhaskar@gmail.com>
Message-ID: <74a983-38ae-b769-7bdf-421bea4f2fc9@bombadil.infradead.org>
References: <20210319015848.19515-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_110136_413264_B5229686 
X-CRM114-Status: GOOD (  12.53  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote: > > s/provisoned/provisioned/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/provisoned/provisioned/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> Documentation/filesystems/vfat.rst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/vfat.rst b/Documentation/filesystems/vfat.rst
> index e85d74e91295..760a4d83fdf9 100644
> --- a/Documentation/filesystems/vfat.rst
> +++ b/Documentation/filesystems/vfat.rst
> @@ -189,7 +189,7 @@ VFAT MOUNT OPTIONS
> **discard**
> 	If set, issues discard/TRIM commands to the block
> 	device when blocks are freed. This is useful for SSD devices
> -	and sparse/thinly-provisoned LUNs.
> +	and sparse/thinly-provisioned LUNs.
>
> **nfs=stale_rw|nostale_ro**
> 	Enable this only if you want to export the FAT filesystem
> --
> 2.26.2
>
>
