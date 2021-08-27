Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A4F3F9C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhH0QZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhH0QZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:25:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634A2C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 09:25:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1so4881808pjv.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olUZYI52FUW5gVkrVAMR5duictYeHKMMzQr6nXakedQ=;
        b=aNaHRKsiD+SM+Lu9zvZtUAsPhN72aJZEO5ggEUbd+9i2E2zx+tYCvMVsH57GRkwHdf
         TEaqxgEcVqpk2OQ9H7VyX1+9BLBU1szPxLHX49NuTsQbgdwMV28fkCyIXIQW5Xd+QD3R
         WQ8/mhACDBZ1RuZyFTGtQQEZWkuERfp+C3Hd1pWoNSnZkvtdCCCdX43x97hoWme9ZdEO
         45oFzDbvZXtq0iWx7LSdO55FY2oYiiyByKOWYg3IoUUbV30sBk3aaucbioyl2Cd8PO6k
         bo+KZEykhRVe2BTh/XS6P2KQyoHNyAxEkUHVXaf1/Vmq1vtUC/5rzUkbwFKRZBjsF7bZ
         26nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olUZYI52FUW5gVkrVAMR5duictYeHKMMzQr6nXakedQ=;
        b=cUDOhiSdqmOMjMBfj7Z6nPfbuZYFRZ1Pczas4mRYOzmVC1pgCGLCN3LpvZW1znNRm2
         I0BtFda51RsEGaXQPNM7/Q1D+HFdEiKDtxBmZKwO7KS9ZpeeuHidt9ZrBHrWZ5lragv5
         jq8D04WDwh/bXuNaJSNknvX1HfbKoMC4WP0vnF5LmnVMRtXOb6cs8Dd2V3YKfYsrY3Kq
         4r9MkU2s/WZDAXxRVLzZ3GOpJoZKePJYtVbrXIANurIU99UPii2m28dDtC3M489RvZ1a
         M6IxCDxlk70GLwbf0REWdsSXoauYhKRanlNXKa6PYBvRGd/3mkD6wPQNstkFLPc4P7k6
         EYPg==
X-Gm-Message-State: AOAM531fDWPuDmWlyknQh/Y/1UKhUePkNwe5XfHbdOc//FcRfMttW9wz
        utO2MSlKXYg/iB1P2/6FOP8/PEtEdHKn0L6Edfq5kg==
X-Google-Smtp-Source: ABdhPJy9Fys2MKe+4NKONrWKg51ffmdsBaOmd1A6Uev8PSTHXgB2mLpKO7Fg2ktC2vZ1DnSMGf/U9PYBzR/IUsq76cs=
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr24462608pjk.13.1630081500678;
 Fri, 27 Aug 2021 09:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-8-iwona.winiarska@intel.com> <CAPcyv4jPVSt9Wr2TkDActFVLP+ygaDwBnsKG410Nf1qfP_MB9A@mail.gmail.com>
 <b26ee278838698289869964fe59578f0d5f7b19c.camel@intel.com>
In-Reply-To: <b26ee278838698289869964fe59578f0d5f7b19c.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 27 Aug 2021 09:24:49 -0700
Message-ID: <CAPcyv4hUm0Ec1+_n0PZ+S0A9Tt1=8oLdeYtEiEnAmntm8PtmKQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] peci: Add peci-aspeed controller driver
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "d.mueller@elsoft.ch" <d.mueller@elsoft.ch>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "zweiss@equinix.com" <zweiss@equinix.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 4:55 PM Winiarska, Iwona
<iwona.winiarska@intel.com> wrote:
>
> On Wed, 2021-08-25 at 18:35 -0700, Dan Williams wrote:
> > On Tue, Aug 3, 2021 at 4:35 AM Iwona Winiarska
> > <iwona.winiarska@intel.com> wrote:
> > >
> > > From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > >
> > > ASPEED AST24xx/AST25xx/AST26xx SoCs supports the PECI electrical
> > > interface (a.k.a PECI wire).
> >
> > Maybe a one sentence blurb here and in the Kconfig reminding people
> > why they should care if they have a PECI driver or not?
>
> Ok, I'll expand it a bit.
[..]
> > > +static int aspeed_peci_xfer(struct peci_controller *controller,
> > > +                           u8 addr, struct peci_request *req)
> > > +{
> > > +       struct aspeed_peci *priv = dev_get_drvdata(controller->dev.parent);
> > > +       unsigned long flags, timeout = msecs_to_jiffies(priv-
> > > >cmd_timeout_ms);
> > > +       u32 peci_head;
> > > +       int ret;
> > > +
> > > +       if (req->tx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX ||
> > > +           req->rx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX)
> > > +               return -EINVAL;
> > > +
> > > +       /* Check command sts and bus idle state */
> > > +       ret = aspeed_peci_check_idle(priv);
> > > +       if (ret)
> > > +               return ret; /* -ETIMEDOUT */
> > > +
> > > +       spin_lock_irqsave(&priv->lock, flags);
> > > +       reinit_completion(&priv->xfer_complete);
> > > +
> > > +       peci_head = FIELD_PREP(ASPEED_PECI_TARGET_ADDR_MASK, addr) |
> > > +                   FIELD_PREP(ASPEED_PECI_WR_LEN_MASK, req->tx.len) |
> > > +                   FIELD_PREP(ASPEED_PECI_RD_LEN_MASK, req->rx.len);
> > > +
> > > +       writel(peci_head, priv->base + ASPEED_PECI_RW_LENGTH);
> > > +
> > > +       memcpy_toio(priv->base + ASPEED_PECI_WR_DATA0, req->tx.buf,
> > > min_t(u8, req->tx.len, 16));
> > > +       if (req->tx.len > 16)
> > > +               memcpy_toio(priv->base + ASPEED_PECI_WR_DATA4, req->tx.buf +
> > > 16,
> > > +                           req->tx.len - 16);
> > > +
> > > +       dev_dbg(priv->dev, "HEAD : 0x%08x\n", peci_head);
> > > +       print_hex_dump_bytes("TX : ", DUMP_PREFIX_NONE, req->tx.buf, req-
> > > >tx.len);
> >
> > On CONFIG_DYNAMIC_DEBUG=n builds the kernel will do all the work of
> > reading through this buffer, but skip emitting it. Are you sure you
> > want to pay that overhead for every transaction?
>
> I can remove it or I can add something like:
>
> #if IS_ENABLED(CONFIG_PECI_DEBUG)
> #define peci_debug(fmt, ...) pr_debug(fmt, ##__VA_ARGS__)
> #else
> #define peci_debug(...) do { } while (0)
> #endif

It's the hex dump I'm worried about, not the debug statements as much.

I think the choices are remove the print_hex_dump_bytes(), put it
behind an IS_ENABLED(CONFIG_DYNAMIC_DEBUG) to ensure the overhead is
skipped in the CONFIG_DYNAMIC_DEBUG=n case, or live with the overhead
if this is not a fast path / infrequently used.

>
> (and similar peci_trace with trace_printk for usage in IRQ handlers and such).
>
> What do you think?

In general, no, don't wrap the base level print routines with
driver-specific ones. Also, trace_printk() is only for debug builds.
Note that trace points are built to be even less overhead than
dev_dbg(), so there's no overhead concern with disabled tracepoints,
they literally translate to nops when disabled.

>
> >
> > > +
> > > +       priv->status = 0;
> > > +       writel(ASPEED_PECI_CMD_FIRE, priv->base + ASPEED_PECI_CMD);
> > > +       spin_unlock_irqrestore(&priv->lock, flags);
> > > +
> > > +       ret = wait_for_completion_interruptible_timeout(&priv-
> > > >xfer_complete, timeout);
> >
> > spin_lock_irqsave() says "I don't know if interrupts are disabled
> > already, so I'll save the state, whatever it is, and restore later"
> >
> > wait_for_completion_interruptible_timeout() says "I know I am in a
> > sleepable context where interrupts are enabled"
> >
> > So, one of those is wrong, i.e. should it be spin_{lock,unlock}_irq()?
>
> You're right - I'll fix it.
>
> >
> >
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       if (ret == 0) {
> > > +               dev_dbg(priv->dev, "Timeout waiting for a response!\n");
> > > +               return -ETIMEDOUT;
> > > +       }
> > > +
> > > +       spin_lock_irqsave(&priv->lock, flags);
> > > +
> > > +       writel(0, priv->base + ASPEED_PECI_CMD);
> > > +
> > > +       if (priv->status != ASPEED_PECI_INT_CMD_DONE) {
> > > +               spin_unlock_irqrestore(&priv->lock, flags);
> > > +               dev_dbg(priv->dev, "No valid response!\n");
> > > +               return -EIO;
> > > +       }
> > > +
> > > +       spin_unlock_irqrestore(&priv->lock, flags);
> > > +
> > > +       memcpy_fromio(req->rx.buf, priv->base + ASPEED_PECI_RD_DATA0,
> > > min_t(u8, req->rx.len, 16));
> > > +       if (req->rx.len > 16)
> > > +               memcpy_fromio(req->rx.buf + 16, priv->base +
> > > ASPEED_PECI_RD_DATA4,
> > > +                             req->rx.len - 16);
> > > +
> > > +       print_hex_dump_bytes("RX : ", DUMP_PREFIX_NONE, req->rx.buf, req-
> > > >rx.len);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static irqreturn_t aspeed_peci_irq_handler(int irq, void *arg)
> > > +{
> > > +       struct aspeed_peci *priv = arg;
> > > +       u32 status;
> > > +
> > > +       spin_lock(&priv->lock);
> > > +       status = readl(priv->base + ASPEED_PECI_INT_STS);
> > > +       writel(status, priv->base + ASPEED_PECI_INT_STS);
> > > +       priv->status |= (status & ASPEED_PECI_INT_MASK);
> > > +
> > > +       /*
> > > +        * In most cases, interrupt bits will be set one by one but also
> > > note
> > > +        * that multiple interrupt bits could be set at the same time.
> > > +        */
> > > +       if (status & ASPEED_PECI_INT_BUS_TIMEOUT)
> > > +               dev_dbg_ratelimited(priv->dev,
> > > "ASPEED_PECI_INT_BUS_TIMEOUT\n");
> > > +
> > > +       if (status & ASPEED_PECI_INT_BUS_CONTENTION)
> > > +               dev_dbg_ratelimited(priv->dev,
> > > "ASPEED_PECI_INT_BUS_CONTENTION\n");
> > > +
> > > +       if (status & ASPEED_PECI_INT_WR_FCS_BAD)
> > > +               dev_dbg_ratelimited(priv->dev,
> > > "ASPEED_PECI_INT_WR_FCS_BAD\n");
> > > +
> > > +       if (status & ASPEED_PECI_INT_WR_FCS_ABORT)
> > > +               dev_dbg_ratelimited(priv->dev,
> > > "ASPEED_PECI_INT_WR_FCS_ABORT\n");
> >
> > Are you sure these would not be better as tracepoints? If you're
> > debugging an interrupt related failure, the ratelimiting might get in
> > your way when you really need to know when one of these error
> > interrupts fire relative to another event.
>
> Tracepoints are ABI(ish), and using a full blown tracepoint just for IRQ status
> would probably be too much.

Tracepoints become ABI once someone ships tooling that depends on them
being there. These don't look  attractive for a tool, and they don't
look difficult to maintain if the interrupt handler needs to be
reworked. I.e. it would be trivial to keep a dead tracepoint around if
worse came to worse to keep a tool from failing to load.

> I was thinking about something like trace_printk hidden under a
> "CONFIG_PECI_DEBUG" (see above), but perhaps that's something for the future
> improvement?

Again trace_printk() is only for private builds.

>
> >
> > > +
> > > +       /*
> > > +        * All commands should be ended up with a ASPEED_PECI_INT_CMD_DONE
> > > bit
> > > +        * set even in an error case.
> > > +        */
> > > +       if (status & ASPEED_PECI_INT_CMD_DONE)
> > > +               complete(&priv->xfer_complete);
> >
> > Hmm, no need to check if there was a sequencing error, like a command
> > was never submitted?
>
> It's handled by checking if HW is idle in xfer before a command is sent, where
> we just expect a single interrupt per command.

I'm asking how do you determine if this status was spurious, or there
was a sequencing error in the driver?
