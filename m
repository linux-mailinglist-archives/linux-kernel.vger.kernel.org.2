Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37B045583F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245284AbhKRJvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbhKRJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:51:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99752C061764
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:48:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u18so10333997wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZtWnV2AZaTtP7W31ku5iWN+RjlPIjMELYCK0vwIHbQ=;
        b=HZWqpB6kFbD+fz5zJokWz51ktHZPeZ7IeIpoCZ407WXMnXPc7wpkgf+Fbv9QgTn6Ms
         zaUZ2kCSuHX+PXyxJ8dDdCRoimWUriQbmsnvAMe8QZCGwH0c4d278pCrnUZ5f8tsU/5I
         K8EscoS8cxrF+j2+pDpkuJmKFJcltxwSG0FqdaX8UPT8KbzpMVXFP3typfVGtKwE3mNt
         ev3kxzF68C3cu0rrv5PDC4hIv7sAtGyWETSaSp6HytSy4bwOEx1PLDlS37Frz4R/xiAS
         KkPr+jAoGY+32/8M3QqiSnfQZ1tXBBcVCQWy8h1TRgMUJYYgcaygaBu7fzvOEX6yU9l4
         w2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZtWnV2AZaTtP7W31ku5iWN+RjlPIjMELYCK0vwIHbQ=;
        b=aP2xT99BbyK4/Oee2y1G21l+yWA37Zy19MxWAlR6V/f/LrCri4JvFHUxAUdz/j0TYi
         bhe8EBAddkEqZKiPrxT/tskfszIPjq+2iAPG7oMMC8TN9S83B1LusGM26nbxibuAsI2E
         ZM16DRxnpgF50JsvMrKBnaltMry9q/TSoxDnnx1yvDs9/j754xZsrfKZQ16taBkE7GeH
         XvgeaYAO8dBF5WZ+YXoHItR79u3U8yv5oYnEygH3T0iDfV6iz46xJlkgW+Xe2heXEI63
         kQ3krJSVqErBu7zm7DOXnTa58DBP64VgyxP7s608pXopeLQiEDS+vbCF+7yiDZ4bifPm
         wD3A==
X-Gm-Message-State: AOAM531KMyH1UtT6SRtOBWhAw7jRfGhZM/5bEhmummPRVLxc7PFq6/tm
        o659zOjcZap35szr+u6cD0fJScXU4T4zDQUMbs4=
X-Google-Smtp-Source: ABdhPJxiBmKacSHCnqardmw88c4Q0OW5/V3fLQzY75pI9koggT83OYbb35ZfIORvxITUz582p+Dl+EQo408sLfo+RiY=
X-Received: by 2002:a5d:598c:: with SMTP id n12mr28836702wri.250.1637228903193;
 Thu, 18 Nov 2021 01:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
 <20211117093734.17407-17-daniel.baluta@oss.nxp.com> <YZU75B2JHbYHy40l@sirena.org.uk>
 <e918b4c4-dc85-dcf5-2781-5edfcd1bf1a5@nxp.com> <CAEnQRZBCc4bhX-sT43KT6Tb-=RK=J9poxRvEM_H=1oXh0_AsPA@mail.gmail.com>
In-Reply-To: <CAEnQRZBCc4bhX-sT43KT6Tb-=RK=J9poxRvEM_H=1oXh0_AsPA@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 18 Nov 2021 11:48:11 +0200
Message-ID: <CAEnQRZAgRW-VRGOsKninEV29NJJH4GjoaOaEAEYbHFqtM3PiHQ@mail.gmail.com>
Subject: Re: [PATCH 16/21] ASoC: SOF: topology: Add support for Mediatek AFE DAI
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, AjitKumar.Pandey@amd.com,
        Balakishore.pati@amd.com, vsreddy@amd.com,
        Julian.Schroeder@amd.com, vishnuvardhanrao.ravulapati@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 11:34 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> Hi Mark,
>
> I noticed that you already applied this. Should I resend the entire
> series or just a fixup?

Later edit: All good. You applied only the AMD patches. Sorry for the noise.

Will fix and resend the MTK patches.
