Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F3530B696
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhBBEge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhBBEgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:36:06 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77CC0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:35:25 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id e1so4511136vkd.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 20:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zW+oK8rbM/GavGAJ5Q7vHYU6QBRDLzYuN7DwE3QzWk=;
        b=fP7IJz6FtgZOxArADJ6ZEDLa+iycwERa5UmG6elnBSUEw7t/gy5P7Ld/teUE3y/8CH
         e5+ojPWEpoahB7LxuLmMBYoYEoTs1pyMA4iR+h/nbU21AX+eFb860NYitY4MRbrPakWw
         mWgqHe1BvfDGbuAXNPZ1Ynr6Cb6K1RZtdAqaT4HKNozpXRQ1Xm3KkrK89q1zkWstDU6u
         /6PMBcV60JBQP7XSi3Q5VwzQOtMRYcxxOfDo8ElVhH+4aESb8igdbi2HGsUubt/mccK8
         12ixy0DS2owR+BURdAWeAQ7/8TCf3rFPb5YRazhcoCLLbK+6dPWGDIbzMiKPzJpA/CUH
         YEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zW+oK8rbM/GavGAJ5Q7vHYU6QBRDLzYuN7DwE3QzWk=;
        b=lVazoAXn5d8kjLsKMNg0v9zDfg2gla92ha0+Cr3z7kyWN1/AMP84C4SglYpUe+3eVS
         aGlkZdI9kl6vPhM6ghifnI1mPgJS7KjvjeE3s+FxEwcEfSX9qznZ5Jy981jGMzLs4wIK
         ZFjtV2Q/OfNX5iYKV/Hyz+Sex3y+ZqPf5fXrAfvxJ1DDw2b9xCmJPeKJdmq7gMoesfoL
         7mDq8+n36eUWOSoLJBBXEg69Z5MVAWl9DGCOeKYn5hkNRod6CccWSlpIvi6fioomuSIk
         SejuqXMqrBVqVjBbm8JBxkIiwvtlo5Mo/K4AGfgFcQedXTcZnAytkFSgzXZcAJcSUXNv
         ysag==
X-Gm-Message-State: AOAM531jWXodBHdnn5qxfyT23Js9iSHsemSo6GgZCWCgamMHnmXZ7M0Q
        +qGqHVkJZuSq+Z6Cb4b8BIsQIFV+V6KQ1X7vWxC/XA==
X-Google-Smtp-Source: ABdhPJytGVZo8olkvv0ZJKLAvArQ8Xgz0PsZ/u3tEaiPcllYumCERl9uyk0rWtRlurPMEoPuA7nEHbip+6kQeT4BNgk=
X-Received: by 2002:a1f:9b83:: with SMTP id d125mr11035160vke.14.1612240524542;
 Mon, 01 Feb 2021 20:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20210202003101.221145-1-badhri@google.com>
In-Reply-To: <20210202003101.221145-1-badhri@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 1 Feb 2021 20:34:47 -0800
Message-ID: <CAPTae5J+rpRUs3fQwXqGe+ScSeF=_fTa3JLNRQy8WnCGzGg7kg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] usb: typec: tcpm: Add Callback to Usb
 Communication capable partner
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>
Cc:     USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Sent V2 version of the patch stack:
https://patchwork.kernel.org/project/linux-usb/list/?series=425705.
For me, Gmail is grouping this under v1 version for some reason and
since you had reviewed one other patch
which was sent later, I was wondering if you are having similar
grouping issue as well.
I am pinging here to make sure that the patch isn't missed.

Thanks,
Badhri

On Mon, Feb 1, 2021 at 4:31 PM Badhri Jagan Sridharan <badhri@google.com> wrote:
>
> The USB Communications Capable bit indicates if port
> partner is capable of communication over the USB data lines
> (e.g. D+/- or SS Tx/Rx). Notify the status of the bit to low
> level drivers to perform chip specific operation.
> For instance, low level driver enables USB switches on D+/D-
> lines to set up data path when the bit is set.
>
> Refactored from patch initially authored by
> Kyle Tso <kyletso@google.com>
>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since V1:
> - Removed partner_usb_comm_capable flag.
> - Fixed capable flag for SNK_NEGOTIATE_CAPABILITIES.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 13 +++++++++++++
>  include/linux/usb/tcpm.h      |  5 +++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0afd8ef692e8..997a1a56c161 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3429,6 +3429,14 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
>         memset(modep, 0, sizeof(*modep));
>  }
>
> +static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, bool capable)
> +{
> +       tcpm_log(port, "Setting usb_comm capable %s", capable ? "true" : "false");
> +
> +       if (port->tcpc->set_partner_usb_comm_capable)
> +               port->tcpc->set_partner_usb_comm_capable(port->tcpc, capable);
> +}
> +
>  static void tcpm_reset_port(struct tcpm_port *port)
>  {
>         int ret;
> @@ -3445,6 +3453,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>         port->attached = false;
>         port->pd_capable = false;
>         port->pps_data.supported = false;
> +       tcpm_set_partner_usb_comm_capable(port, false);
>
>         /*
>          * First Rx ID should be 0; set this to a sentinel of -1 so that
> @@ -3785,6 +3794,8 @@ static void run_state_machine(struct tcpm_port *port)
>                         }
>                 } else {
>                         tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> +                       tcpm_set_partner_usb_comm_capable(port,
> +                                                         !!(port->sink_request & RDO_USB_COMM));
>                         tcpm_set_state(port, SRC_TRANSITION_SUPPLY,
>                                        PD_T_SRC_TRANSITION);
>                 }
> @@ -4004,6 +4015,8 @@ static void run_state_machine(struct tcpm_port *port)
>                 break;
>         case SNK_NEGOTIATE_CAPABILITIES:
>                 port->pd_capable = true;
> +               tcpm_set_partner_usb_comm_capable(port,
> +                                                 !!(port->source_caps[0] & PDO_FIXED_USB_COMM));
>                 port->hard_reset_count = 0;
>                 ret = tcpm_pd_send_request(port);
>                 if (ret < 0) {
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 3af99f85e8b9..42fcfbe10590 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -108,6 +108,10 @@ enum tcpm_transmit_type {
>   *             is supported by TCPC, set this callback for TCPM to query
>   *             whether vbus is at VSAFE0V when needed.
>   *             Returns true when vbus is at VSAFE0V, false otherwise.
> + * @set_partner_usb_comm_capable:
> + *              Optional; The USB Communications Capable bit indicates if port
> + *              partner is capable of communication over the USB data lines
> + *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
>   */
>  struct tcpc_dev {
>         struct fwnode_handle *fwnode;
> @@ -139,6 +143,7 @@ struct tcpc_dev {
>         int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
>                                                  bool pps_active, u32 requested_vbus_voltage);
>         bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
> +       void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
>  };
>
>  struct tcpm_port;
> --
> 2.30.0.365.g02bc693789-goog
>
