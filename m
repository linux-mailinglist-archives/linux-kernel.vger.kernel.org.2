Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D72457AD8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 04:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhKTDhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 22:37:32 -0500
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:48794 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235314AbhKTDh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 22:37:29 -0500
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 25F08181A8B08;
        Sat, 20 Nov 2021 03:34:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 6FF0F801921E;
        Sat, 20 Nov 2021 03:34:24 +0000 (UTC)
Message-ID: <a14da924805afdc39d7df800d3d4b7dc81c3dbf1.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: update designated reviewer entry for MSM
 DRM driver
From:   Joe Perches <joe@perches.com>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, gregkh@linuxfoundation.org,
        robdclark@gmail.com, seanpaul@chromium.org, swboyd@chromium.org,
        nganji@codeaurora.org, aravindh@codeaurora.org,
        dmitry.baryshkov@linaro.org, daniel@ffwll.ch
Date:   Fri, 19 Nov 2021 19:34:23 -0800
In-Reply-To: <1637363916-18257-1-git-send-email-quic_abhinavk@quicinc.com>
References: <1637363916-18257-1-git-send-email-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6FF0F801921E
X-Spam-Status: No, score=-1.89
X-Stat-Signature: ty5f3kaua5ywwhsnr7axqu4sdhpfxtw9
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19ONcUnkDqSylS7FefYZckB+A9ZdWXuflY=
X-HE-Tag: 1637379264-765151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-19 at 15:18 -0800, Abhinav Kumar wrote:
> Adding myself as a designated reviewer to assist with the
> code reviews for the changes coming into MSM DRM.
> 
> Acked-by: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -5938,6 +5938,7 @@ M:	Sean Paul <sean@poorly.run>
>  L:	linux-arm-msm@vger.kernel.org
>  L:	dri-devel@lists.freedesktop.org
>  L:	freedreno@lists.freedesktop.org
> +R:	Abhinav Kumar <quic_abhinavk@quicinc.com>
>  S:	Maintained
>  T:	git https://gitlab.freedesktop.org/drm/msm.git
>  F:	Documentation/devicetree/bindings/display/msm/

R: goes after M: not L:


