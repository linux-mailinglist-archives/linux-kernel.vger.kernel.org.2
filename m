Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7109362322
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbhDPOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbhDPOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:48:12 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBFBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:47:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k128so14456550wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzbFiG9qlpfDdBD13oBbx/SnXgaf7lM7Uh11a+woNxo=;
        b=oloX02my2DG75fIjQsd9fk+ufF6/rJTpEC0A5Dc5tFRol9W5+YhORJkY5l0uynzOR8
         eiyB4MRkc3PNuqYiUwsovz4hyzIyvWnWKbgOBmEbIunuePoIcOvqR5t5cBN4w6odXFJw
         7q28cgr1aSeo5g7i18+9ILQURJO7Cjz11nGGIRGQ0A0V6MBjMmT8TGvxrasFbANYzgAF
         qIoonecTFvV2Yu4k0cyRrw1cJBOfpeUc2KHofyPZMqPlFW+3a+xOFr3x0qGQ1x1Zs/jP
         25Fr5VEJS0n0PtMT+VW23ISmqEsLcG9emYca24+EubDPveczLvgXdTcP+HhvpsVGcwNM
         ftZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzbFiG9qlpfDdBD13oBbx/SnXgaf7lM7Uh11a+woNxo=;
        b=XRB/8reKaVUCLqJPspjnyDVBCTWNHb3vjYLCM5wkBJF5YadlmGS7JiA5B2nz1dfyaW
         J2sPYydl455ln1D7QUX7ZdSR8CFzrS7kPXb9bEYHmG62k6BxneXJqjMhf2rZCLDKrluk
         10HiUHCpIv9bkjU2PigisJQlZ4hi1UUnAJRRnYijkMivELrFlK6BeSayFqjblKrMwnux
         gU47w+zoqx11GD9ixbrGGE62xxpm2UUV+AA1vp9jorEyFI25/NtbvPXSIfqoR0ZI150N
         5nt5uaID8xe9670yPpIavDoLkGKoGzj3n09b5sNO6ofWqaXXuDEbFVOUeb0IFGO3DLF5
         ZMGA==
X-Gm-Message-State: AOAM5336HYSd5mUcgmxAsMfQXFPlZ9N1UCItk7XWjYa726/8lfJxSLu3
        IailP7BTP2JcdR7ZytAA/N8jPDpRYKCOIcxe+rIprQ==
X-Google-Smtp-Source: ABdhPJw8TNCT09SVYtFw+t1BqHeD1SvJYq6ZPRqCl2OpMlSBOGDcvzHCzmDOK1UozMbIj99zVX4qz8BTnVbHIjcArYs=
X-Received: by 2002:a1c:87:: with SMTP id 129mr8752442wma.131.1618584465874;
 Fri, 16 Apr 2021 07:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <4c91ac77d6a9def6e521c6a2aeaa32eb@codeaurora.org>
In-Reply-To: <4c91ac77d6a9def6e521c6a2aeaa32eb@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 16 Apr 2021 15:47:35 +0100
Message-ID: <CAJ9a7VhKLcptnONy2ZAQxWZb1eREU6fn-voU9xon_nw7gVKPqQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: arm: add property for coresight
 component name
To:     taozha@codeaurora.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, 16 Apr 2021 at 15:16, <taozha@codeaurora.org> wrote:
>
> On 2021-04-16 19:23, Alexander Shishkin wrote:
> > Tao Zhang <taozha@codeaurora.org> writes:
> >
> >> Add property "coresight-name" for coresight component name. This
> >> allows coresight driver to read device name from device entries.
> >>
> >> Signed-off-by: Tao Zhang <taozha@codeaurora.org>
> >> ---
> >>  Documentation/devicetree/bindings/arm/coresight.txt | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt
> >> b/Documentation/devicetree/bindings/arm/coresight.txt
> >> index d711676..0e980ce 100644
> >> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> >> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> >> @@ -103,6 +103,8 @@ its hardware characteristcs.
> >>        powers down the coresight component also powers down and loses its
> >>        context. This property is currently only used for the ETM 4.x
> >> driver.
> >>
> >> +    * coresight-name: the name of the coresight devices.
> >
> > Which devices? Also, is it a common practice to extend device tree
> > definitions based on arbitrary driver needs, or should there be some
> > sort of a discussion first?
> >
> > Regards,
> > --
> > Alex
> Through the device tree entries, we can define their own name for any
> coresight device. This design is mainly used to facilitate the unified
> naming of coresight devgies across targets. e.g, without this patch, we
> can only see from sysFS there are multiple funnels, but we cannot know
> which funnel it is based on their names from sysFS. After applying this
> patch, we can directly know what device it is by observing the device
> name in sysFS. And the common scripts can be developed, since applying
> this patch, the same coresight device can have the same name across
> targets. Each developer or vendor can define the name of each coresight
> device according to their preferences and products.
>
> Tao

1) I am concerned that this will break the existing protocol which
associates a fixed device type name + number with each device - i.e.
etm0, funnel1 etc.
This naming convention allows for generic common scripts to be developed - see:
./tools/perf/tests/shel/test_arm_coresight.sh
This relies on the device type prefixes to iterate across all devices
in a system - and uses the connections links that are present in each
of the devices to determine the topology.
Replacing these with arbitrary names will break existing scripts.

2) Using the current system it is entirely possible to determine which
specific device a given name relates to.
e.g. ls -al /sys/bus/coresight/devices/

lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_cpu0 ->
../../../devices/platform/soc/858000.cti/cti_cpu0
lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_cpu1 ->
../../../devices/platform/soc/859000.cti/cti_cpu1
lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_cpu2 ->
../../../devices/platform/soc/85a000.cti/cti_cpu2
lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_cpu3 ->
../../../devices/platform/soc/85b000.cti/cti_cpu3
lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_sys0 ->
../../../devices/platform/soc/810000.cti/cti_sys0
lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_sys1 ->
../../../devices/platform/soc/811000.cti/cti_sys1
lrwxrwxrwx 1 root root 0 Apr 14 19:02 etm0 ->
../../../devices/platform/soc/85c000.etm/etm0
lrwxrwxrwx 1 root root 0 Apr 14 19:02 etm1 ->
../../../devices/platform/soc/85d000.etm/etm1
lrwxrwxrwx 1 root root 0 Apr 14 19:02 etm2 ->
../../../devices/platform/soc/85e000.etm/etm2
lrwxrwxrwx 1 root root 0 Apr 14 19:02 etm3 ->
../../../devices/platform/soc/85f000.etm/etm3
lrwxrwxrwx 1 root root 0 Apr 16 14:17 funnel0 ->
../../../devices/platform/soc/821000.funnel/funnel0
lrwxrwxrwx 1 root root 0 Apr 16 14:17 funnel1 ->
../../../devices/platform/soc/841000.funnel/funnel1
lrwxrwxrwx 1 root root 0 Apr 16 14:17 replicator0 ->
../../../devices/platform/soc/824000.replicator/replicator0
lrwxrwxrwx 1 root root 0 Apr 16 14:17 tmc_etf0 ->
../../../devices/platform/soc/825000.etf/tmc_etf0
lrwxrwxrwx 1 root root 0 Apr 16 14:17 tmc_etr0 ->
../../../devices/platform/soc/826000.etr/tmc_etr0
lrwxrwxrwx 1 root root 0 Apr 16 14:17 tpiu0 ->
../../../devices/platform/soc/820000.tpiu/tpiu

Further topology can be determined using the connections sub-directory
in each device:-

ls -al  /sys/bus/coresight/devices/etm0/connections/out\:0
lrwxrwxrwx 1 root root 0 Apr 16 14:18
/sys/bus/coresight/devices/etm0/connections/out:0 ->
../../../841000.funnel/funnel1

Using this information it is possible to iterate across the entire
topology of any coresight system.

3) If there is some scripting requirement that cannot be solved with
the information available above - then it would be better to add this
name as an alias rather than a direct replacement.
Therefore any coresight device could have an alias_name entry, that
could be interrogated by a script and used as required. This avoids
breaking any existing scripts using the established naming convention.

4) Any devicetree attribute should follow the <owner>,<attribute>
naming convention. e.g. arm,some_attribute.
I agree with Alex that it may not be normal practice to add in
attributes in these circumstances - this does not appear to relate to
a specific hardware feature or limitation. You may wish to discuss
this with the device tree maintainers.

Thanks and Regards

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
