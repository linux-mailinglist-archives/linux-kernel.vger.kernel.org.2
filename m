Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2836736CA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhD0RUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235647AbhD0RUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:20:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFF80613DC;
        Tue, 27 Apr 2021 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619544009;
        bh=zTDfkBlhzaw3mRPFZOF8YBGAy6SJ6egNfmcUdq7dV7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/A22uVISgT59GGjSXX5oORcYXIWLPfUzpCb1ND+S5HVrjtZJcAyYJm7CUZZLx6QJ
         y1zERveu++1+6qbdNnjDcBmxUVaYxh3PyR5ULG0I0YNT5Qm1zBesvF6tj0gCeXQ5v8
         HqP0ROUfcYTv0pr4uavOlR5idc6Wgy8NqAfcYwLw=
Date:   Tue, 27 Apr 2021 19:20:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Manish Rangankar <mrangankar@marvell.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 110/190] Revert "scsi: qla4xxx: fix a potential NULL
 pointer dereference"
Message-ID: <YIhHx42O3FTsL3MS@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-111-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-111-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:45PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit fba1bdd2a9a93f3e2181ec1936a3c2f6b37e7ed6.
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
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Manish Rangankar <mrangankar@marvell.com>
> Cc: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index 7bd9a4a04ad5..5cb0dfe7a83b 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -3229,8 +3229,6 @@ static int qla4xxx_conn_bind(struct iscsi_cls_session *cls_session,
>  	if (iscsi_conn_bind(cls_session, cls_conn, is_leading))
>  		return -EINVAL;
>  	ep = iscsi_lookup_endpoint(transport_fd);
> -	if (!ep)
> -		return -EINVAL;
>  	conn = cls_conn->dd_data;
>  	qla_conn = conn->dd_data;
>  	qla_conn->qla_ep = ep->dd_data;
> -- 
> 2.31.1
> 

Looks to be correct.  Odd that you do not have to "unbind" after calling
iscsi_conn_bind(), but hey, it's scsi functions, they are always odd :)

I'll drop this revert.

greg k-h
