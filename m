Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AFC3C3E89
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhGKRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 13:48:42 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:56318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230399AbhGKRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:48:41 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 37FAE182CF66A;
        Sun, 11 Jul 2021 17:45:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 7BF461E04D4;
        Sun, 11 Jul 2021 17:45:50 +0000 (UTC)
Message-ID: <a8f75357ab3bd3b37269e51a38aafa997307570f.camel@perches.com>
Subject: Re: [PATCH] drm/amd/display: Fix identical code for different
 branches
From:   Joe Perches <joe@perches.com>
To:     Len Baker <len.baker@gmx.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Wenjing Liu <wenjing.liu@amd.com>,
        Martin Tsai <martin.tsai@amd.com>,
        Kees Cook <keescook@chromium.org>,
        George Shen <George.Shen@amd.com>,
        Yu-ting Shen <Yu-ting.Shen@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 11 Jul 2021 10:45:48 -0700
In-Reply-To: <20210711172433.2777-1-len.baker@gmx.com>
References: <20210711172433.2777-1-len.baker@gmx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7BF461E04D4
X-Spam-Status: No, score=0.11
X-Stat-Signature: 7ma6bo74edffc1o15s1gyp3aqp9y57xd
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/HO52DK1P6z6FVcGIy7yHO2Mioju5SxhI=
X-HE-Tag: 1626025550-417702
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-07-11 at 19:24 +0200, Len Baker wrote:
> The branches of the "if" statement are the same. So remove the
> unnecessary if and goto statements.
> 
> Addresses-Coverity-ID: 1456916 ("Identical code for different branches")
> Fixes: 4c283fdac08ab ("drm/amd/display: Add HDCP module")
> Signed-off-by: Len Baker <len.baker@gmx.com>

I'm not a big fan of this type of change.

It's currently the same style used for six tests in this function
and changing this last one would just make it harder to see the
code blocks as consistent.

I doubt any reasonable compiler would produce different objects.

> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
[]
> @@ -305,10 +305,8 @@ static enum mod_hdcp_status wait_for_ready(struct mod_hdcp *hdcp,
>  				hdcp, "bcaps_read"))
>  			goto out;
>  	}
> -	if (!mod_hdcp_execute_and_set(check_ksv_ready,
> -			&input->ready_check, &status,
> -			hdcp, "ready_check"))
> -		goto out;
> +	mod_hdcp_execute_and_set(check_ksv_ready, &input->ready_check, &status,
> +				 hdcp, "ready_check");
>  out:
>  	return status;
>  }
> --
> 2.25.1
> 


