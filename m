Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA75C3660E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhDTU3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:29:23 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.79]:38748 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233682AbhDTU3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:29:21 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id C0A7E14A9D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:28:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwzIlm21PPkftYwzIlzru9; Tue, 20 Apr 2021 15:28:48 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xb9N7Jsx/GlDsx+8cy7TfYtbXj2e5xdFzA0RMDZFGS4=; b=vyRURm0PlfCotJhgp8bACFJrlx
        p5eb3bn+44IBTSTReooJji6rAKKYPmQPuR51wmZysPNMxshY5678nfL6NJraLJkbrNMM4p/W3/TI/
        T7SrAGWqNMGxScqkAfDsI+HVNsUnfqQ1Y9+4uH+qwLuSi9CH6cqxogZFL67g4nwxWy2m66IFIkHo8
        79c9ANn3tylDcuW4anbtrPkM6BBjiOM4gMPAmrCs7qDt2i3wEF/nJDXvxQudqnDkQggaxWqkqHPp/
        rsjOHdAp3MtX7zdlVRaAcLtnPcnYeW1zPedY5mh5vWgP99T5yxGbLFwHemJ+izNFehc6bW/oVKpzj
        QAI0uc1A==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49080 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwzG-003Adg-Cn; Tue, 20 Apr 2021 15:28:46 -0500
Subject: Re: [PATCH 006/141] gfs2: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <84d07c8510abf95c9e656454961c09b14485b856.1605896059.git.gustavoars@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <5adf738a-315b-a80e-46ff-06822441a789@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:29:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <84d07c8510abf95c9e656454961c09b14485b856.1605896059.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lYwzG-003Adg-Cn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49080
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 222
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 11/20/20 12:25, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple goto statements instead of just
> letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/gfs2/inode.c    | 2 ++
>  fs/gfs2/recovery.c | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 077ccb1b3ccc..9a85214c2505 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -960,6 +960,7 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
>  		break;
>  	case 0:
>  		error = -EEXIST;
> +		goto out_gunlock;
>  	default:
>  		goto out_gunlock;
>  	}
> @@ -1500,6 +1501,7 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
>  			break;
>  		case 0:
>  			error = -EEXIST;
> +			goto out_gunlock;
>  		default:
>  			goto out_gunlock;
>  		}
> diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
> index c26c68ebd29d..5b2a01d9c463 100644
> --- a/fs/gfs2/recovery.c
> +++ b/fs/gfs2/recovery.c
> @@ -437,6 +437,7 @@ void gfs2_recover_func(struct work_struct *work)
>  		case GLR_TRYFAILED:
>  			fs_info(sdp, "jid=%u: Busy\n", jd->jd_jid);
>  			error = 0;
> +			goto fail;
>  
>  		default:
>  			goto fail;
> 
