Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952D531C0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhBORdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhBOQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:44:44 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37683C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:44:03 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m6so4507322pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=33j1CgCUh3TWUoQ0xJDvwUExbx7Q5rZOkjB3QkdUKDQ=;
        b=onFXJfeWdIwyD3pNMy9IHHdBIMyx5rIo+uuSmuEqK0oFapfbq+tc/M+/mfIABldMvK
         XK3ypvhkrPW+q91jhhkkyB/Q7L4B6DfB1OAiEBqH22olr2Ns+08/XoaI1Wey+CjODWBU
         LE6VdLg3dNCX825LUvz/lxIy/O557X+AfcjrltnbYZyjMNqgWvFykFrN+22NpPF1r6L9
         JV/zIY5zUyQYbfWmAoORHilGbQJh+HWpm+u6ZvSV+5/rZmfBXXpGbkHEIl4yi6s4iWOb
         cu95PxkROmmIlpsfpiLVo20GCHs6hd7vD7qAqEW2i2r8DflB3+tUSldyrUPeKSchd2Rr
         mCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=33j1CgCUh3TWUoQ0xJDvwUExbx7Q5rZOkjB3QkdUKDQ=;
        b=S+unw5ATBUEiRD/kDlL8h9GzL8XsmoU5kcyzqy3H8L5kaalNjkbK9SM1pcpytDw7cr
         rtwrSAa0/rwe226YLK0HenFI8FWWdcOq9fFP8SLCRKrBbFTujh6+ZQq/rPUjPJ0zA7N+
         RPpgc4NCH5OtEgtGyH49za9KTDcPpmp7n3FBl3PDrkXk/qVvePosb8pR6aLKdna8me/M
         IlZh1KZgITJNLt6Vj6CPNQwn7fxucZHzYPZ2XnV+aYgVGLa4m/B353KZxf9caIvbOl5H
         qutVxvvoj/sDhZiXeTM2Vo1N8KGZGFSffTvv0PuP8/GGfNPaorWpOUtbL1UAvNlmiVkv
         c/Pg==
X-Gm-Message-State: AOAM531Z3QmN93vK57xEktiWorPh0jAbUpMluyx92E73VZnX/bca6Dnr
        RpSzlX3wmggir7qqXdJ60SeE1g==
X-Google-Smtp-Source: ABdhPJw4J4gtZMLXZERaHYawEcxlFYDMgSyAhN2XHJI0VfN07x36PQRutew8OTy+jkiQAH8ZPluKow==
X-Received: by 2002:aa7:94b5:0:b029:1d7:f868:e48d with SMTP id a21-20020aa794b50000b02901d7f868e48dmr16215808pfl.9.1613407442601;
        Mon, 15 Feb 2021 08:44:02 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q13sm11919246pfg.155.2021.02.15.08.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:44:02 -0800 (PST)
Date:   Mon, 15 Feb 2021 09:44:00 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv2] coresight: etm4x: Add ETM PID for Cortex-A78
Message-ID: <20210215164400.GA2770547@xps15>
References: <20210213112829.26834-1-saiprakash.ranjan@codeaurora.org>
 <CAJ9a7VgwxXgs+Zrb2LgX=E7i1+0wpqiL6gOyktPF7_0eojeVNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VgwxXgs+Zrb2LgX=E7i1+0wpqiL6gOyktPF7_0eojeVNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 10:26:38AM +0000, Mike Leach wrote:
> Reviewed-by: Mike Leach <mike.leach@linaro.org>

I will pick this up when 5.12-rc1 comes out.

Thanks,
Mathieu

> 
> On Sat, 13 Feb 2021 at 11:28, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
> >
> > Add ETM PID for Cortex-A78 to the list of supported ETMs.
> >
> > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > ---
> >
> > Changes in v2:
> >  * Rebased on top of coresight/next from kernel.org coresight repo.
> >
> > ---
> >  drivers/hwtracing/coresight/coresight-etm4x-core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index 15016f757828..a5b13a7779c3 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -1951,6 +1951,7 @@ static const struct amba_id etm4_ids[] = {
> >         CS_AMBA_UCI_ID(0x000bbd05, uci_id_etm4),/* Cortex-A55 */
> >         CS_AMBA_UCI_ID(0x000bbd0a, uci_id_etm4),/* Cortex-A75 */
> >         CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
> > +       CS_AMBA_UCI_ID(0x000bbd41, uci_id_etm4),/* Cortex-A78 */
> >         CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
> >         CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
> >         CS_AMBA_UCI_ID(0x000bb802, uci_id_etm4),/* Qualcomm Kryo 385 Cortex-A55 */
> >
> > base-commit: 06c18e28c402ecfb842df8e22a19a097c35ffca9
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> >
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
