Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9C435E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhJUJyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhJUJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:54:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3BC061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:52:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id om14so113961pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s8GVDPZbs1ohxYG57S1dcGlrQ4Cx6gTTkx49YWQo1/c=;
        b=TwLcgLjgX9bYFD9eP5Ek3yEmNQwbBBbTuYbS0GCTt8UPoCz0WD0KO7lFf3pTynd0ZX
         JdEEMM371ajf16tU1ZPWxOdXpoBJr2TW7Hh/vgp2G5YdsCD/pVdqjdaDLGlufEgE9T8d
         Xs1rc1IaOEjBukh0YfYMNfZnaY0LCdnoXSsJg40grYzOZMkK5AzRKu8cAJQXnySYy0B2
         BpLHHgUAX/MVR1jvpvjpoW4K99fEUD2QXLeBVU4ft2b3gXILrxStHYdAQBHtZ/kdWi0l
         FMLSO9YsbotJp0Km+8WGH+isWZlJyY328MvcWT5DqOvMuz+zMurFvFK4usUKZsBt2lMh
         KuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s8GVDPZbs1ohxYG57S1dcGlrQ4Cx6gTTkx49YWQo1/c=;
        b=5sO0BRl9A0zRfUoOO3tLXFjRXpyG5I2i3Dzrv8aqwbV0J2B9kPd0yQnsns1MXHvtBv
         uS/Ye2PQ+S/RksiBIcf2rWZviF9RKP5An4HgDBgoOLtx6zdCulWaKjk2mJTVzWSMrslj
         OYKgTQQ/sXX61yEuekAtXAm25+tIr/Q0ve+KaMyrBPyg8ZksDTg6lPf1hy+wobr1L7vu
         1m86IkWa4H8nuS3xbcMtAfXll5LbjXDJs8a65LOzzb5hT7x0FBtF5uy09mfPhEp9AkiK
         POJF0pgQM9Jdrqp7JisslAwHYHAdFrYJJpdLeswes4Ld3bNxNAPofl883zO8u+dqnRm7
         HXAA==
X-Gm-Message-State: AOAM533NvtEDG7rLn2x1hnlJvlsamLVRd1ujkuaEvPtjIQFVeb+uR66X
        gxZ8oQacRWZbp4q10P2LyqLz0w==
X-Google-Smtp-Source: ABdhPJyeAs/gDABnfkFtqVaOrAQk5aInjWCwAYmhk/Ty1XhXPWQqE50SiTVAYX4TqbR1cqwh1gOSww==
X-Received: by 2002:a17:90a:e547:: with SMTP id ei7mr5538859pjb.169.1634809951794;
        Thu, 21 Oct 2021 02:52:31 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id p8sm5923077pfo.112.2021.10.21.02.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 02:52:31 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:22:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH V6] gpio: virtio: Add IRQ support
Message-ID: <20211021095229.lqeb7dtxv4ix2vc5@vireshk-i7>
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
 <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
 <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
 <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-21, 12:42, Andy Shevchenko wrote:
> On Thu, Oct 21, 2021 at 7:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 20-10-21, 18:10, Andy Shevchenko wrote:
> > > IIRC you add dead code. IRQ framework never calls this if type is not set.
> >
> > Yes, but it is allowed to call
> >
> > irq_set_irq_type(irq, IRQ_TYPE_NONE);
> >
> > and the irq framework won't disallow it AFAICT.
> 
> That's true, but how you may end up in this callback with a such?
> What the meaning of that call to the user?
 
I can see few calls like this in the kernel (mostly from irq-providers
only), but yeah sure I can drop it. We will error out if it ever gets
called and so can get it back later if required.
 
> > > >  struct virtio_gpio_config {
> > > >         __le16 ngpio;
> > > >         __u8 padding[2];
> > > > @@ -44,4 +56,17 @@ struct virtio_gpio_response_get_names {
> > > >         __u8 value[];
> > > >  };
> > > >
> > > > +/* Virtio GPIO IRQ Request / Response */
> > > > +struct virtio_gpio_irq_request {
> > > > +       __le16 gpio;
> > > > +};
> > > > +
> > > > +struct virtio_gpio_irq_response {
> > > > +       __u8 status;
> > > > +};
> > > >
> > > I’m wondering if those above should be packed.
> >
> > You are talking about the newly added ones or the ones before ?
> >
> > In any case, they are all already packed (i.e. they have explicit
> > padding wherever required) and properly aligned. Compiler won't add
> > any other padding to them.
> 
> Is it only for 64-bit to 64-bit communications?

That's what I have been looking at.

> If there is a possibility to have 32-bit to 64-bit or vice versa
> communication you have a problem.

This should work as well.

The structure will get aligned to the size of largest element and each
element will be aligned to itself. I don't see how this will break
even in case of 32/64 bit communication.

-- 
viresh
