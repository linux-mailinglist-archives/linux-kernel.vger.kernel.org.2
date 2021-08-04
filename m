Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826A43E09E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhHDVOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhHDVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:14:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA722C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:13:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so7519172pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pWeVOPuGe2rwR/ROAXUfTRwXClu2H2NNWD6p4NOstS8=;
        b=PwQjaVNp8FyJDWyiUT0Z8kpUGe8+CNzROVRPRHgR/dDii1HFfBEbPrU/LViRYGNseN
         Goj+KxfWobnXG2w+YLWviBprLG/E4CYFs5ur6vBD4C4FjyBuhWYZBwdt9yS3hFRCov+O
         05y8JHO7qSM6VF8APQ8FAENHjfM94RLB7TQbg2uSgzLFH1T75yxAq5MnrBIBQ/5i4OYl
         EyjjbTHapBQVbJdkZoqYsUsEvzG2fwFK+Ua9xM1bWcClktpFT34aEgwdnOq3Zj2ivvXm
         D6PIGidNR5JuWZWtkjLpC/B+UNKt/GVXYwGP4jiAiWFmcJ89K5kB9YCQV3nh5LJ/EoUS
         +A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pWeVOPuGe2rwR/ROAXUfTRwXClu2H2NNWD6p4NOstS8=;
        b=rEQHEtGDCuD5YH3B0rWVYYHwvTX/CZ6BerAnu7sU6PTMxo7hwgZgzAHGPViVIvEenk
         Ssrsh1/bzn2H0M/OO2jm4LsPF7w7AzKzjSLLrisMQPyWEfUA+qs4FSpMo24s7WXxN3Fl
         wTNFvfsrZ+xud6/Q9/SGcD3Z2WFDJabOufXgfDSkWjACDMnjY6bbvdSGqcFZywG/hS7x
         GHDcOoXIcyJJuqovBJKFag5Wx7ZTseF85Jv2jDvMsJm++tDhSFHgXLLwqdnrw6CF6BU+
         sZ5sLby5F0g9DGUpAykZGSKA0Eh6//lpbI3VJFXiU4xYszgOLWGiTcYbutvmojSvc/wQ
         O2XA==
X-Gm-Message-State: AOAM533vPQt9seVJCh1nksnGpIQTv5C4lqUZkcjZ/JwlqppGQNMaGcl8
        NpG4kZHelwoJpxdEsTZzpDCCxA==
X-Google-Smtp-Source: ABdhPJxmNRnC1qh7wzjVxVKaFhVi5Z3hxxqwFofh38QlmmnLtXqmkYyJ4V9kVrsfo+kv7/42Wvm31A==
X-Received: by 2002:a62:1d06:0:b029:3ab:9703:b6b8 with SMTP id d6-20020a621d060000b02903ab9703b6b8mr1372593pfd.0.1628111628112;
        Wed, 04 Aug 2021 14:13:48 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w15sm3279146pjc.45.2021.08.04.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 14:13:47 -0700 (PDT)
Date:   Wed, 04 Aug 2021 14:13:47 -0700 (PDT)
X-Google-Original-Date: Wed, 04 Aug 2021 14:13:46 PDT (-0700)
Subject:     Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
In-Reply-To: <CAOnJCUL9uU5G1LOgfYPz9Ny77yFYaP5sgtdxG3_w=Zcsi+f96Q@mail.gmail.com>
CC:     bmeng.cn@gmail.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        michael.zhu@starfivetech.com, tekkamanninja@gmail.com,
        jack.zhu@starfivetech.com, leyfoon.tan@starfivetech.com,
        geert@linux-m68k.org, kernel@esmil.dk, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org, drew@beagleboard.org
Message-ID: <mhng-c9300c9e-6877-492f-a290-7c51066d3920@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021 13:54:16 PDT (-0700), atishp@atishpatra.org wrote:
> On Wed, Aug 4, 2021 at 1:33 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Thu, 15 Jul 2021 19:17:23 PDT (-0700), bmeng.cn@gmail.com wrote:
>> > On Tue, Jul 13, 2021 at 2:34 PM Drew Fustini <drew@beagleboard.org> wrote:
>> >>
>> >> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
>> >> BeagleV Starlight JH7100 board [2].
>> >>
>> >> [1] https://github.com/starfive-tech/beaglev_doc
>> >> [2] https://github.com/beagleboard/beaglev-starlight
>> >>
>> >> Signed-off-by: Drew Fustini <drew@beagleboard.org>
>> >> ---
>> >> v4 changes:
>> >> - removed JH7100 SoC revision number after discussion with Geert
>> >>
>> >> v3 changes:
>> >> - added revision number for the board and soc after question from Palmer
>> >>
>> >> v2 changes:
>> >> - removed "items:" entry that only had "const: starfive,jh7100"
>> >> - correct typo in Description:
>> >>
>> >> Results of running checks:
>> >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
>> >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
>> >>     CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
>> >>     DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
>> >>     SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
>> >>     DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
>> >>     CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
>> >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
>> >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
>> >>     SYNC    include/config/auto.conf.cmd
>> >>     UPD     include/config/kernel.release
>> >>     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>> >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dtb
>> >>     DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
>> >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
>> >>     DTC     arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
>> >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
>> >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
>> >>     CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
>> >>
>> >> The dts file is from vendor repo and is being cleaned up right now in
>> >> preperation for submitting to the mailing list:
>> >> https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
>> >>
>> >>  .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
>> >>  1 file changed, 27 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
>> >>
>> >
>> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>>
>> Thanks.  This is on for-next, as Rob suggested taking it via the RISC-V
>> tree.
>>
> Given that beagleV starlight mass production is cancelled [1], are we
> still upstreaming the support for this ?

I'm not sure, but I wasn't quite sure where to have that discussion.  I 
figured that the boards exist so there's no reason to shoot this down, 
given that it's just the vendor DT list.  At a bare minimum there's out 
of tree support for this, so having the DT strings defined seems sane as 
that's a defacto interface with bootloaders.

Maybe this is more of a question for Drew: I think we were all OK 
working through the issues with the first-run chip when there was going 
to be a lot of them, but with such a small number produced I'm not sure 
if there's going to be enough interested to take on all that effort.  

I'm not quite sure where we stand on support for this: at some point 
there were some ideas floating around as to a way to support it without 
major software changes (allocating into the non-caching regions).  If 
that pans out then I'm fine handling this, at least from the RISC-V 
side, but if we're going to have to go through all the ISA/SBI stuff 
then it's probably not worth it.  Also not sure if there are a bunch of 
starfive-specific drivers that would be needed to make this boot, in 
which case it's probably best to wait for whatever comes next.

>
> [1] https://www.cnx-software.com/2021/07/31/beaglev-starlight-sbc-wont-be-mass-manufactured-redesigned-beaglev-risc-v-sbc-expected-in-q1-2022/
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
