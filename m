Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFC414F78
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhIVR44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhIVR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:56:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16454C061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:55:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id bb10so2311363plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6/SvUCLfRyuYu1lKmX4nHf8QBxdiwH9kaaV9XM1Ggm8=;
        b=V4COAh086f0J3K5wQ255OK38XeEoSGgfq69vq27PFOFJ64c4VZxummhpm3Xv+PLJZ2
         MWjIJJE8ctLSeJRv0MixAyRL+nbbFd5KlsRNxXdmD6sFrDaG5l3I7WkUyW/uk+vR3NAF
         uqIMKOz5iGaDnuR+/zYA2c4jXswTjp1qRk37dkbwcktYAL6Z+B21ZyWVnB6bDqMUOGEN
         cahlxmuYO3u4B0DuSBGtkC8TaGXEBguvWBUiJZzcuVehRIUetDQgpjgX0EmvGJOz+VO/
         4Fpb2pKHRgMXuFUsMDeOMQDWM8zQREEBmLjQA9CIYNjvJwFO3p7J/2o2Zsv/yoBeyAQu
         T6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6/SvUCLfRyuYu1lKmX4nHf8QBxdiwH9kaaV9XM1Ggm8=;
        b=JgfY/A7bJyxQ1cO/wbd68rglhO08qMjBMBV5pWytG2fsbMMekfXQ/GgqaGPRt1gmMS
         71DwbPGzMmPU3CQxS5Q3CEWrK0BKu8tcxtAbFooh/ie/sZ/FxZHAtDMHwozieMUCUCny
         +0MR5zzfJ6JIGB8GrzTwvc1xAE10G82CbgOdSS36RQS04gJMt99kQDcsQcYNXrpyuqdr
         sV3kS42ucFBctbonhYAnTZl+w0BMnFxrMTABHpDAAm2SCVw3XLPUNMPTSytlKpOwKUYz
         XVQ2FwTbbQ25mdzJafocc0czoF5Mm+xCbjVVe2mwcfFwrR2Me4JqWopgUC/ECqb0Ve0M
         jT1Q==
X-Gm-Message-State: AOAM5324pCYQprVxZ/P4rkMKEXBMb9gMrRVgfYSfXNIbCYnh1FhOej5s
        o8JiR9ensB2XC62nUPxNqv3rIw==
X-Google-Smtp-Source: ABdhPJwrVgSn5gY/ZBiHP0dKEBG0qvC4QE9UF3HQyT382gRtLxnLi3BKane1/nUm25ZgdhIIk4atBA==
X-Received: by 2002:a17:90b:3b41:: with SMTP id ot1mr12765719pjb.186.1632333324544;
        Wed, 22 Sep 2021 10:55:24 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n66sm3132665pfn.142.2021.09.22.10.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 10:55:23 -0700 (PDT)
Date:   Wed, 22 Sep 2021 11:55:21 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] remoteproc: imx_dsp_rproc: Add remoteproc driver
 for DSP on i.MX
Message-ID: <20210922175521.GA2157824@p14s>
References: <1631092255-25150-1-git-send-email-shengjiu.wang@nxp.com>
 <1631092255-25150-4-git-send-email-shengjiu.wang@nxp.com>
 <20210915161624.GA1770838@p14s>
 <CAA+D8AO0c+jk_k7j=ZvNFsVvC-p_zMLPJDS3qmLjNbJ+U0E9Cg@mail.gmail.com>
 <20210916165957.GA1825273@p14s>
 <CAA+D8AN_ni_XmEFNfY0Z0qLAJX00XFSUP1RkJdNQd-MVY6pd4g@mail.gmail.com>
 <CAA+D8AMaszzT5q8oGhXOtE3W5Ue9S3r=es2sTp2uJ7RwjX8Bzg@mail.gmail.com>
 <20210917152236.GA1878943@p14s>
 <CAA+D8ANwXZdXheMkV8VHJ90JT8o+9YXFuE-EjTejijGUa4YALw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANwXZdXheMkV8VHJ90JT8o+9YXFuE-EjTejijGUa4YALw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 09:35:54AM +0800, Shengjiu Wang wrote:
> Hi Mathieu
> 
> On Fri, Sep 17, 2021 at 11:22 PM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > On Fri, Sep 17, 2021 at 05:44:44PM +0800, Shengjiu Wang wrote:
> > > On Fri, Sep 17, 2021 at 1:20 PM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 17, 2021 at 1:00 AM Mathieu Poirier
> > > > <mathieu.poirier@linaro.org> wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * imx_dsp_rproc_elf_load_segments() - load firmware segments to memory
> > > > > > > > + * @rproc: remote processor which will be booted using these fw segments
> > > > > > > > + * @fw: the ELF firmware image
> > > > > > > > + *
> > > > > > > > + * This function specially checks if memsz is zero or not, otherwise it
> > > > > > > > + * is mostly same as rproc_elf_load_segments().
> > > > > > > > + */
> > > > > > > > +static int imx_dsp_rproc_elf_load_segments(struct rproc *rproc,
> > > > > > > > +                                        const struct firmware *fw)
> > > > > > > > +{
> > > > > > > > +     struct device *dev = &rproc->dev;
> > > > > > > > +     u8 class = fw_elf_get_class(fw);
> > > > > > > > +     u32 elf_phdr_get_size = elf_size_of_phdr(class);
> > > > > > > > +     const u8 *elf_data = fw->data;
> > > > > > > > +     const void *ehdr, *phdr;
> > > > > > > > +     int i, ret = 0;
> > > > > > > > +     u16 phnum;
> > > > > > > > +
> > > > > > > > +     ehdr = elf_data;
> > > > > > > > +     phnum = elf_hdr_get_e_phnum(class, ehdr);
> > > > > > > > +     phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
> > > > > > > > +
> > > > > > > > +     /* go through the available ELF segments */
> > > > > > > > +     for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
> > > > > > > > +             u64 da = elf_phdr_get_p_paddr(class, phdr);
> > > > > > > > +             u64 memsz = elf_phdr_get_p_memsz(class, phdr);
> > > > > > > > +             u64 filesz = elf_phdr_get_p_filesz(class, phdr);
> > > > > > > > +             u64 offset = elf_phdr_get_p_offset(class, phdr);
> > > > > > > > +             u32 type = elf_phdr_get_p_type(class, phdr);
> > > > > > > > +             void *ptr;
> > > > > > > > +             bool is_iomem;
> > > > > > > > +
> > > > > > > > +             if (type != PT_LOAD || !memsz)
> > > > > > >
> > > > > > > You did a really good job with adding comments but this part is undocumented...
> > > > > > > If I read this correctly you need to check for !memsz because some part of
> > > > > > > the program segment may have a header but its memsz is zero, in which case it can
> > > > > > > be safely skipped.  So why is that segment in the image to start with, and why
> > > > > > > is it marked PT_LOAD if it is not needed?  This is very puzzling...
> > > > > >
> > > > > > Actually I have added comments in the header of this function.
> > > > >
> > > > > Indeed there is a mention of memsz in the function's header but it doesn't
> > > > > mention _why_ this is needed, and that is what I'm looking for.
> > > > >
> > > > > >
> > > > > > memsz= 0 with PT_LOAD issue, I have asked the toolchain's vendor,
> > > > > > they said that this case is allowed by elf spec...
> > > > > >
> > > > > > And in the "pru_rproc.c" and "mtk_scp.c", seems they met same problem
> > > > > > they also check the filesz in their internal xxx_elf_load_segments() function.
> > > > >
> > > > > In both cases they are skipping PT_LOAD sections where "filesz" is '0', which
> > > > > makes sense because we don't know how many bytes to copy.  But here you are
> > > > > skipping over a PT_LOAD section with a potentially valid filesz, and that is the
> > > > > part I don't understand.
> > > >
> > > > Ok, I can use filesz instead. For my case, filesz = memsz = 0,
> > > > it is the same result I want.
> >
> > If that is the case then rproc_elf_load_segments() should work, i.e it won't
> > copy anything.  If rproc_elf_load_segments() doesn't work for you then there are
> > corner cases you haven't told me about.
> >
> > > >
> > > > The reason why I use "memsz '' is because there is  "if (filesz > memsz) "
> > > > check after this,  if memsz is zero, then "filesz" should be zero too, other
> > > > values are not allowed.
> > >
> > > But I still think checking "!memsz" is better than filesz,  because
> > > memsz > filesz is allowed (filesz = 0),  the code below can be executed.
> > > filesz > memsz is not allowed.

The question remains the same - have you seen instances where memsz > filesz?
Also, can you point me to the reference where it is said that memsz is allowed?
And if it is allowed than how do we know that this program section has valid
data, because after all, filesz is 0?

> > >
> > > What do you think?
> >
> > I don't see a need to add a custom implementation for things that _may_ happen.
> > If using the default rproc_elf_load_segments() works than go with that.  We can deal
> > with problems if/when there is a need for it.
> >
> 
> The default rproc_elf_load_segments() with filesz = memsz = 0, then the
> rproc_da_to_va() return ptr=NULL, then rproc_elf_load_segments() will return
> with error.  So this is the reason to add a custom implementation.

Ok, I see about rproc_da_to_va() returning NULL and failing everything from
there one.

> 
> best regards
> wang shengjiu
