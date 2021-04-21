Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAF366E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhDUOdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243607AbhDUOdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619015588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ou0yh2vWHqTiMG7xo0EqymuXKeFeRblF6ggxSMp3/Ik=;
        b=EYo0Z2NH1latuKaRzyyeYLKhgPzfS7UPpzJO0cmTyr7LTze453XzE4b02VctwBZdvOHnLE
        IlMK/Ze1qzoAFCerfzbK4B8G/MmayrqydkOryeLqPdtk4pDob5sydOvTOchDSGB2pf3ZzT
        rssdEw2ARnCiigsgcnR9rNL4BzVsK58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-5aTFxaIrMbOAAQQ64GfmfA-1; Wed, 21 Apr 2021 10:32:58 -0400
X-MC-Unique: 5aTFxaIrMbOAAQQ64GfmfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09319343B3;
        Wed, 21 Apr 2021 14:32:56 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-129.rdu2.redhat.com [10.10.118.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7A0E5B4A0;
        Wed, 21 Apr 2021 14:32:55 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id E65C31203AD; Wed, 21 Apr 2021 10:32:54 -0400 (EDT)
Date:   Wed, 21 Apr 2021 10:32:54 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 065/190] Revert "nfsd: remove unnecessary assertion in
 nfsd4_encode_replay"
Message-ID: <YIA3lhTMV2Ib1KLx@pick.fieldses.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-66-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-66-gregkh@linuxfoundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was fine, NAK to the revert.

--b.

On Wed, Apr 21, 2021 at 02:59:00PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit fc1b20659597015a30e8ea032f168e97848c1d39.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: J. Bruce Fields <bfields@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/nfsd/nfs4xdr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index eaaa1605b5b5..a3609562671c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5385,6 +5385,8 @@ nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op)
>  	__be32 *p;
>  	struct nfs4_replay *rp = op->replay;
>  
> +	BUG_ON(!rp);
> +
>  	p = xdr_reserve_space(xdr, 8 + rp->rp_buflen);
>  	if (!p) {
>  		WARN_ON_ONCE(1);
> -- 
> 2.31.1
> 

