Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7531EFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhBRTbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhBRSr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:47:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6DFC06178B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:46:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gb24so1871264pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=TYSvMCIPacqOphOa16rzA+X+0GuBxuIS4Qj5ygoV2IM=;
        b=aWV5hnEy8rnECOEGtDuAcE+s4yLDrZzLFVj+vn97GLn50xSeuxHfgdHF7Yz6jpcksB
         CYfZpw1Zh4nmKvytWq2vjdYlJZlmbDpatiO45blzVexSo6J8CdGpJ/r3/Jfht+NfQhSW
         LOtBc1iiEAii0nADT1I0ZZyiE9uk7n6kjhupE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=TYSvMCIPacqOphOa16rzA+X+0GuBxuIS4Qj5ygoV2IM=;
        b=YuoRpiChY9uYxAHV5zShydKxBNbF+lIlBpzTUXVK7ylI4f+JjUWP5eeXU8/fUJHTb6
         sDHy0e6MHJXfy3LvknvoX9hONGiuyZHHDbikCMDW9ezqoBN/wHdAiwYP99n0oNjHY8oR
         ZAksdoD2QgYXATaGjJzq7JIncM5eu2Nzs7CzZxPk2L4kd9L9gdd2tSVrnNtNTYZz7B5G
         Yi0wXtNfdlKsa1424HB/zhR6jy/yhDZ7rdVEjuHWjhB+HuXfc20WxRlN3k0vYQiZjzhM
         ndNgUXIRN23o6IafGwdzikeK5D5Xnvj5Jr2PcDlMHK4cgHHgHzFdJwMwsevRFW/33cCJ
         O1WA==
X-Gm-Message-State: AOAM531AnkhoOhAF2Uv5ZOXwdv4xyd2t3HhIsKexYsBRAJm1O9StQVtr
        lSzuGcHHuve6EwdeyS7qNIge7w==
X-Google-Smtp-Source: ABdhPJxCmb8Y1Km73TqeTEgYOkLH188D40vElREuf0w7ub9wbnNw7oCNpoGFosfaLftBUBdQlyWCeg==
X-Received: by 2002:a17:902:aa03:b029:e3:721:c093 with SMTP id be3-20020a170902aa03b02900e30721c093mr5267903plb.50.1613674006193;
        Thu, 18 Feb 2021 10:46:46 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:ec84:ed2b:a796:b756])
        by smtp.gmail.com with ESMTPSA id 25sm7127704pfh.199.2021.02.18.10.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 10:46:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613603397-21179-1-git-send-email-khsieh@codeaurora.org>
References: <1613603397-21179-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH 2/2] drm/msm/dp: Drop limit link rate at HBR2
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Thu, 18 Feb 2021 10:46:44 -0800
Message-ID: <161367400432.1254594.2213007173465217655@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-02-17 15:09:57)
> Drop limit link rate at HBR2 to support link rate
> upto HBR3.
>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
