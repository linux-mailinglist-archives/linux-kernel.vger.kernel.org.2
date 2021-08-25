Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE93F7A50
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbhHYQU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbhHYQTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:19:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E3C0617AD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:18:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso3959151wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKeaJCWjOOEPA9mHt+LQea3HRZxpjWyYQFmzHIUWRcA=;
        b=anm+B1cEPMlV+o9gItfyVh0l3OY+cNSK/Z+EltiqHedNrxdw6nTiLCO2rs+gFtrcdF
         6t3E8rrRAC5xPqii8y70jr6ygFm+faIqEUSwf8yKHuh0yprqBOrN2Wg0p7qKPOtwXN2t
         er2q6nxF7QdJ8YG0Gwr+rafyV0FG0h121yDBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKeaJCWjOOEPA9mHt+LQea3HRZxpjWyYQFmzHIUWRcA=;
        b=ZXMV6KHJiAyIYHTyJdXdaxkR9XgaP65G/hVwGMXR1C3uOWstzBDqkeBNGyz07aztbO
         q3oaNIXVq5rqzqAoi2TN9xwOGcIl8U0rwH07s1TFkl0PmhxUEtBupglsDDU+LYXA0Dcm
         0l1Jrk/lKAtrJCEpnV3VjzwEniEXvfQUqkk8JjTqVBa/ZezsAist/mYPS0w/reX80Vzq
         leRrs8v6gszia7t0dTxQEeh9eftf5NqDLoqT8cCfi/YyIr8KjWLUuv/OYoeFUu7YEGxS
         sHoGcZb2rFt0qZh/fP3RW76IDU1/Im1qFMBDEgmPZ8bSjf+5c/L0XcsLwfli7U1sNJbe
         F/jw==
X-Gm-Message-State: AOAM531DS1q24BN33N3wmcYCyoYl5R0YLGJd2159F4Pdjz7SdbyRFU29
        XerDhPcGfbvl8cqo7R7ofiSHvQJL7ClrhiWlI6g1ctluMyk=
X-Google-Smtp-Source: ABdhPJwvU5xYHuvYD+Df2qyMExmk4H3Vl58MnuiWXvt72qgffNlsJqo9CI1wiDzZ+Jy/uuuW7lhoHesAQkkIDrqeEWw=
X-Received: by 2002:a05:600c:3b91:: with SMTP id n17mr10046623wms.72.1629908323166;
 Wed, 25 Aug 2021 09:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210824135941.38656-1-cristian.marussi@arm.com> <20210824135941.38656-4-cristian.marussi@arm.com>
In-Reply-To: <20210824135941.38656-4-cristian.marussi@arm.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 25 Aug 2021 12:18:31 -0400
Message-ID: <CA+-6iNzTN6UHVX4qRssrqv6YVKeg97+Lz1KDcEcw6saMC0tubw@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] firmware: arm_scmi: Add support for atomic transports
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        etienne.carriere@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a5ca4305ca649ab0"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a5ca4305ca649ab0
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

On Tue, Aug 24, 2021 at 10:00 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> An SCMI transport can declare itself as .atomic_capable in order to signal
> to the SCMI core that all its transmit path can be executed in atomic
> context: the core as a consequence will take care not to sleep to in the
> corresponding rx path while waiting for a response or a delayed response.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h |   3 +
>  drivers/firmware/arm_scmi/driver.c | 167 ++++++++++++++++++++++-------
>  2 files changed, 132 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 67c761141a48..4ab310c2eae5 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -412,6 +412,8 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
>   * @max_msg_size: Maximum size of data per message that can be handled.
>   * @force_polling: Flag to force this whole transport to use SCMI core polling
>   *                mechanism instead of completion interrupts even if available.
> + * @atomic_capable: Flag to indicate that this transport is assured not to sleep
> + *                 on the TX path.
>   */
>  struct scmi_desc {
>         int (*transport_init)(void);
> @@ -421,6 +423,7 @@ struct scmi_desc {
>         int max_msg;
>         int max_msg_size;
>         bool force_polling;
> +       bool atomic_capable;
>  };
>
>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index a3700f49e8ac..2ca1602afd80 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -681,6 +681,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
>                 scmi_clear_channel(info, cinfo);
>                 complete(xfer->async_done);
>         } else {
> +               /*
> +                * This same xfer->done completion is used in atomic mode as a
> +                * flag for polling.
> +                */
>                 complete(&xfer->done);
>         }
>
> @@ -733,8 +737,6 @@ static void xfer_put(const struct scmi_protocol_handle *ph,
>         __scmi_xfer_put(&info->tx_minfo, xfer);
>  }
>
> -#define SCMI_MAX_POLL_TO_NS    (100 * NSEC_PER_USEC)
> -
>  static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
>                                       struct scmi_xfer *xfer, ktime_t stop)
>  {
> @@ -749,6 +751,90 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
>                ktime_after(ktime_get(), stop);
>  }
>
> +static bool xfer_complete_or_timeout(struct completion *done, ktime_t stop)
> +{
> +       return try_wait_for_completion(done) || ktime_after(ktime_get(), stop);
> +}
> +
> +static int spin_for_completion_timeout(struct completion *done, int timeout_ms)
> +{
> +       ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
> +
> +       spin_until_cond(xfer_complete_or_timeout(done, stop));
> +       if (ktime_after(ktime_get(), stop))
> +               return -ETIMEDOUT;
> +
> +       return 0;
> +}
> +
> +/**
> + * scmi_wait_for_message_response  - An helper to group all the possible ways of
> + * waiting for a synchronous message response.
> + *
> + * @cinfo: SCMI channel info
> + * @xfer: Reference to the transfer being waited for.
> + *
> + * Chooses waiting strategy (sleep-waiting vs busy-waiting) depending on flags
> + * configuration like xfer->hdr.poll_completion and scmi_desc.atomic.capable.
> + *
> + * Return: 0 on Success, error otherwise.
> + */
> +static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
> +                                         struct scmi_xfer *xfer)
> +{
> +       struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
> +       struct device *dev = info->dev;
> +       int ret = 0, timeout_ms = info->desc->max_rx_timeout_ms;
> +
> +       if (!xfer->hdr.poll_completion) {
> +               if (!info->desc->atomic_capable) {
> +                       if (!wait_for_completion_timeout(&xfer->done,
> +                                                        msecs_to_jiffies(timeout_ms))) {
> +                               dev_err(dev, "timed out in resp(caller: %pS)\n",
> +                                       (void *)_RET_IP_);
> +                               ret = -ETIMEDOUT;
> +                       }
> +               } else {
> +                       /* Poll on xfer->done waiting for completion by interrupt */
> +                       ret = spin_for_completion_timeout(&xfer->done,
> +                                                         timeout_ms);
We use the SMC transport with a completion interrupt but would prefer
for the above to use wait_for_completion(...) instead of  using
spin_for_completion().  A few of our SCMI commands can take a while to
complete execution so we do not want to be spinning or polling while
waiting.

We could probably go back to a mailbox-based transport and use delayed
messages here for these "long" SCMI messages,  but we do not have full
control over the platform FW (plus there are backwards compatibility
issues).  FWIW, the platform FW was setup before SCMI on Linux
implemented delayed/async  messages.

Regards,
Jim Quinlan
Broadcom STB


> +                       if (ret)
> +                               dev_err(dev,
> +                                       "timed out in resp(caller: %pS) - atomic\n",
> +                                       (void *)_RET_IP_);
> +               }
> +       } else {
> +               /*
> +                * Poll on xfer using transport provided .poll_done();
> +                * assumes no completion interrupt was available.
> +                */
> +               ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
> +
> +               spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
> +               if (ktime_before(ktime_get(), stop)) {
> +                       unsigned long flags;
> +
> +                       /*
> +                        * Do not fetch_response if an out-of-order
> +                        * delayed response is being processed.
> +                        */
> +                       spin_lock_irqsave(&xfer->lock, flags);
> +                       if (xfer->state == SCMI_XFER_SENT_OK) {
> +                               info->desc->ops->fetch_response(cinfo, xfer);
> +                               xfer->state = SCMI_XFER_RESP_OK;
> +                       }
> +                       spin_unlock_irqrestore(&xfer->lock, flags);
> +               } else {
> +                       dev_err(dev,
> +                               "timed out in resp(caller: %pS) - polling\n",
> +                               (void *)_RET_IP_);
> +                       ret = -ETIMEDOUT;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
>  /**
>   * do_xfer() - Do one transfer
>   *
> @@ -763,7 +849,6 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>                    struct scmi_xfer *xfer)
>  {
>         int ret;
> -       int timeout;
>         const struct scmi_protocol_instance *pi = ph_to_pi(ph);
>         struct scmi_info *info = handle_to_scmi_info(pi->handle);
>         struct device *dev = info->dev;
> @@ -810,36 +895,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>                 return ret;
>         }
>
> -       if (xfer->hdr.poll_completion) {
> -               ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> -
> -               spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
> -               if (ktime_before(ktime_get(), stop)) {
> -                       unsigned long flags;
> -
> -                       /*
> -                        * Do not fetch_response if an out-of-order delayed
> -                        * response is being processed.
> -                        */
> -                       spin_lock_irqsave(&xfer->lock, flags);
> -                       if (xfer->state == SCMI_XFER_SENT_OK) {
> -                               info->desc->ops->fetch_response(cinfo, xfer);
> -                               xfer->state = SCMI_XFER_RESP_OK;
> -                       }
> -                       spin_unlock_irqrestore(&xfer->lock, flags);
> -               } else {
> -                       ret = -ETIMEDOUT;
> -               }
> -       } else {
> -               /* And we wait for the response. */
> -               timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
> -               if (!wait_for_completion_timeout(&xfer->done, timeout)) {
> -                       dev_err(dev, "timed out in resp(caller: %pS)\n",
> -                               (void *)_RET_IP_);
> -                       ret = -ETIMEDOUT;
> -               }
> -       }
> -
> +       ret = scmi_wait_for_message_response(cinfo, xfer);
>         if (!ret && xfer->hdr.status)
>                 ret = scmi_to_linux_errno(xfer->hdr.status);
>
> @@ -861,7 +917,7 @@ static void reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
>         xfer->rx.len = info->desc->max_msg_size;
>  }
>
> -#define SCMI_MAX_RESPONSE_TIMEOUT      (2 * MSEC_PER_SEC)
> +#define SCMI_DRESP_TIMEOUT     (2 * MSEC_PER_SEC)
>
>  /**
>   * do_xfer_with_response() - Do one transfer and wait until the delayed
> @@ -870,22 +926,57 @@ static void reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
>   * @ph: Pointer to SCMI protocol handle
>   * @xfer: Transfer to initiate and wait for response
>   *
> + * Avois sleeping in favour of busy-waiting if the underlying transport was
> + * declared as .atomic_capable.
> + *
> + * Note that using asynchronous commands when running on top of atomic
> + * transports should be avoided since it could cause long busy-waiting here,
> + * but, once a transport is declared atomic, upper layers using the SCMI stack
> + * can freely make assumptions about the 'non-sleeping' nature of the stack
> + * (e.g. Clock framework) and it cannot be excluded that asynchronous commands
> + * could be exposed by the platform and so used.
> + *
> + * The only other option would have been to refrain from using any asynchronous
> + * command even if made available, when an atomic transport is detected, and
> + * instead forcibly use the synchronous version (thing that can be easily
> + * attained at the protocol layer), but this would also have led to longer
> + * stalls of the channel for synchronous commands and possibly timeouts.
> + * (in other words there is usually a good reason if a platform provides an
> + *  asynchronous version of a command and we should prefer to use it)
> + *
>   * Return: -ETIMEDOUT in case of no delayed response, if transmit error,
>   *     return corresponding error, else if all goes well, return 0.
>   */
>  static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
>                                  struct scmi_xfer *xfer)
>  {
> -       int ret, timeout = msecs_to_jiffies(SCMI_MAX_RESPONSE_TIMEOUT);
> +       int ret, timeout = msecs_to_jiffies(SCMI_DRESP_TIMEOUT);
> +       const struct scmi_protocol_instance *pi = ph_to_pi(ph);
> +       struct scmi_info *info = handle_to_scmi_info(pi->handle);
>         DECLARE_COMPLETION_ONSTACK(async_response);
>
>         xfer->async_done = &async_response;
>
>         ret = do_xfer(ph, xfer);
>         if (!ret) {
> -               if (!wait_for_completion_timeout(xfer->async_done, timeout))
> -                       ret = -ETIMEDOUT;
> -               else if (xfer->hdr.status)
> +               if (!info->desc->atomic_capable) {
> +                       if (!wait_for_completion_timeout(xfer->async_done,
> +                                                        timeout)) {
> +                               dev_err(ph->dev,
> +                                       "timed out in delayed resp(caller: %pS)\n",
> +                                       (void *)_RET_IP_);
> +                               ret = -ETIMEDOUT;
> +                       }
> +               } else {
> +                       ret = spin_for_completion_timeout(xfer->async_done,
> +                                                         SCMI_DRESP_TIMEOUT);
> +                       if (ret)
> +                               dev_err(ph->dev,
> +                                       "timed out in delayed resp(caller: %pS) - atomic\n",
> +                                       (void *)_RET_IP_);
> +               }
> +
> +               if (!ret && xfer->hdr.status)
>                         ret = scmi_to_linux_errno(xfer->hdr.status);
>         }
>
> --
> 2.17.1
>

--000000000000a5ca4305ca649ab0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LeylbuEJGL9I80yqq8e6Z+Q6ulLxa6SopzpoysJe/vEVHgp9jPNppZzwKngVd2iDBRqpKlCngIAM
DXgVGyEojXnuEbRs3NlB7wq1kJGlYysrnDug55ncJM8CAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFCeTeUYv84Mo3T1V+OyDdxib
DDLvMA0GCSqGSIb3DQEBCwUAA4IBAQCCqR1PBVtHPvQHuG8bjMFQ94ZB7jmFEGhgfAsFJMaSMLov
qyt8DKr8suCYF4dKGzqalbxo5QU9mmZXdLifqceHdt/Satxb+iGJjBhZg4E0cDds24ofYq+Lbww2
YlIKC2HHxIN+JX2mFpavSXkshR5GT29B9EIJ8hgSjbs61XXeAcrmVIDfYbXQEmGbsnwqxdq+DJpQ
S2kM2wvSlgSWDb6pL7myuKR5lCkQhj7piGSgrVLJRDRrMPw1L4MvnV9DjUFMlGCB40Hm6xqn/jm0
8FCLlWhxve5mj+hgUOPETiKbjhCxJhhAPDdCvDRkZtJlQ8oxUVvXHugG8jm1YqB5AWx7MYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMI+Aj9XRk/wFexb9/
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAIGSlJgC/8a9NkyWjK2WiaknLZeHwM
ufvsMAXgBuBHRTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA4
MjUxNjE4NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAfo4r+K1fWJcCKN88BiKB+Ei6l4D/I7X6JmNZcurv9V8Qh7VO
7Sua3D+VbncWMKtmE0XGRx1OkoX0n7Wz/beN+5H84mi2mrNYh4cZbFZfvI5XxBcTSR0o3hPZaxTe
1KPTh07N57fSpR86m/gW2WAoVEiIbccFmLJoHBezOJ91V59oxtlLzgmGouHmuxFMR0P8jUEo1LvC
HgKPtac7yH2TrvskpoqMw5FBIyEJijDdWm9nGzebyGKr2eH5MoSdNauoREQXBcRsXR6Hqu7dLmQm
WorHgomfbLvTlMAse8yNKjDbjbA9dnHRU9JO97cpNd0bGCQwU4Paz5s3ffnVeVTuPg==
--000000000000a5ca4305ca649ab0--
