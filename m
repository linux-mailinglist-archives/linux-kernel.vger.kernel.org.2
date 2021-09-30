Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B482541DF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352008AbhI3QfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351235AbhI3QfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:35:05 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3593C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:33:22 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso8019235otb.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6il0YsB1u07XrEjL6UToDW7bxsUfzL4X0YSwrMv6RAU=;
        b=GWoUgKIUmlJAesMzEQ0g1Oq55aq7DEJwAR60nRriwRZ0XmAq48kcPlWynnKbtGgbuX
         QCo+TnQ57X7OVvjsVxJFou+tqEbQqorxw4p6e4AujvKCwG79ISOmZHcThSw/3Cu7Lx19
         cN61ye+NjqH64Dap2tfl8Eo2E4rTKiLxD2Kho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6il0YsB1u07XrEjL6UToDW7bxsUfzL4X0YSwrMv6RAU=;
        b=xgNHpjnO64xoaPl1cNLxVptLHlRT6dtmq5DuwnWupLdIovGrE5KlqGEP+tOfbD+mZu
         ES9Pb87tZbh5W22UwnuF2g4WJCa7Wvx4ourooAE1Tj+yqcNrln7cMIz4PuzYWDj3uj2z
         VtsJyxOP2/kwPkT7tid6NKhp5W0LIGBOLi9LNp7dFYwbYVXbUQVUBxtzVveQPATeBdYS
         DzwY7uHwuFvIr8b+7QunrNHz3hVU4RiOvV7XZadWN+m2xbDALq4mTU2rc1vdca+IwuSX
         37HtztNW0dCx1uuwj6/8hiOi6U3XdeshoJfNhsYcGhStRKpuD775IvekCNgQkiLMCJRd
         B1gQ==
X-Gm-Message-State: AOAM533VFbwSD0nygegVyQoP0dA+ny0qvmpXhLeHrRxO6NdNy86sjOUS
        LAkPOmNtYXr2AbziNgb5mty3/eeqYriAJ/8f5Aj+1H21Bd4=
X-Google-Smtp-Source: ABdhPJyfg8wA4FLIK4t09eCr4cNEB5fDhR5+3AC+oZNHy7BEHMCMDs0mE7qsVwPd3+24uG/XdamDu1281AsdtPxuJC8=
X-Received: by 2002:a05:6830:708:: with SMTP id y8mr5996176ots.77.1633019602013;
 Thu, 30 Sep 2021 09:33:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Sep 2021 09:33:21 -0700
MIME-Version: 1.0
In-Reply-To: <1633015924-881-4-git-send-email-deesin@codeaurora.org>
References: <1633015924-881-1-git-send-email-deesin@codeaurora.org> <1633015924-881-4-git-send-email-deesin@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 30 Sep 2021 09:33:21 -0700
Message-ID: <CAE-0n52Wn6_70-3Y6a+Yk5zkoA_hiA5w51rTeCVX-DN37Gc=ig@mail.gmail.com>
Subject: Re: [PATCH V1 2/3] rpmsg: glink: Add support to handle signals command
To:     Deepak Kumar Singh <deesin@codeaurora.org>,
        bjorn.andersson@linaro.org, clew@codeaurora.org,
        mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Deepak Kumar Singh (2021-09-30 08:32:03)
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 05533c7..384fcd2 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -976,6 +984,68 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
>         return 0;
>  }
>
> +/**
> + * qcom_glink_set_flow_control() - convert a signal cmd to wire format and
> + *                                transmit
> + * @ept:       Rpmsg endpoint for channel.
> + * @enable:    True/False - enable or disable flow control
> + *
> + * Return: 0 on success or standard Linux error code.
> + */
> +static int qcom_glink_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
> +{
> +       struct glink_channel *channel = to_glink_channel(ept);
> +       struct qcom_glink *glink = channel->glink;
> +       struct glink_msg msg;
> +       u32 sigs = 0;

Drop assignment.

> +
> +       /**
> +        * convert signals from TIOCM to NATIVE
> +        * sigs = TIOCM_DTR|TIOCM_RTS
> +        */
> +       if (enable)
> +               sigs |= (NATIVE_DTR_SIG | NATIVE_CTS_SIG);

sigs = NATIVE_DTR_SIG | NATIVE_CTS_SIG;

> +       else
> +               sigs |= (~(NATIVE_DTR_SIG | NATIVE_CTS_SIG));

sigs = ~(NATIVE_DTR_SIG | NATIVE_CTS_SIG);

> +
> +       msg.cmd = cpu_to_le16(RPM_CMD_SIGNALS);
> +       msg.param1 = cpu_to_le16(channel->lcid);
> +       msg.param2 = cpu_to_le32(sigs);
> +
> +       return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
> +}
> +
> +static int qcom_glink_handle_signals(struct qcom_glink *glink,
> +                                    unsigned int rcid, unsigned int sigs)
> +{
> +       struct glink_channel *channel;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&glink->idr_lock, flags);

irqsave can be skipped because this is only called from an irq handler.

> +       channel = idr_find(&glink->rcids, rcid);
> +       spin_unlock_irqrestore(&glink->idr_lock, flags);
> +       if (!channel) {
> +               dev_err(glink->dev, "signal for non-existing channel\n");
> +               return -EINVAL;
> +       }
> +
> +       /* convert signals from NATIVE to TIOCM */
> +       if (sigs & NATIVE_DTR_SIG)
> +               sigs |= TIOCM_DSR;
> +       if (sigs & NATIVE_CTS_SIG)
> +               sigs |= TIOCM_CTS;
> +       if (sigs & NATIVE_CD_SIG)
> +               sigs |= TIOCM_CD;
> +       if (sigs & NATIVE_RI_SIG)
> +               sigs |= TIOCM_RI;
> +       sigs &= 0x0fff;

Is this to only keep TIOCM_* bits? Maybe make this an ORed together mask
of those bits so we know what 0xfff means.

> +
> +       if (channel->ept.sig_cb)
> +               channel->ept.sig_cb(channel->ept.rpdev, channel->ept.priv, sigs);
> +
> +       return 0;
> +}
> +
>  static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>  {
>         struct qcom_glink *glink = data;
> @@ -1037,6 +1107,10 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>                         qcom_glink_handle_intent_req_ack(glink, param1, param2);
>                         qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>                         break;
> +               case RPM_CMD_SIGNALS:
> +                       qcom_glink_handle_signals(glink, param1, param2);

Should the return value be handled and if there isn't a channel then
treat it as a spurious irq?

> +                       qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
> +                       break;
>                 default:
>                         dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
>                         ret = -EINVAL;
