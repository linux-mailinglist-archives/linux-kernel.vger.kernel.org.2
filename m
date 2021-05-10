Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F7F378DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347853AbhEJMvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:51:36 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:63249 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbhEJMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:08:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620648472; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=Pr7oVgy/TwNgZLycUMTvmyajdlOEew/ao5SQV8BcBjk=; b=A/AHv3SLgh8Wua1leZvTGLk8JklGUAsVelQKQc4Hl8+2DyI4aPhTR0ExtN4gdEyyucUGdRDi
 1z/ew7aYIGhPrJ1H/OR28bjACX/1KiIk28ckAPdAMS6OefQHLQ6jk37vGd4g6+hXn5ASiAqA
 uWZkcXzIK/t6kSwDWwoOZqYDOq4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60992203e0e9c9a6b6e4dfb3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 May 2021 12:07:31
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4E1BC4479C; Mon, 10 May 2021 12:07:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84BA8C43143;
        Mon, 10 May 2021 12:07:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 May 2021 20:07:29 +0800
From:   taozha@codeaurora.org
To:     Mike Leach <mike.leach@linaro.org>
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
Subject: Re: [PATCH v1 2/2] dt-bindings: arm: add property for coresight
 component name
Message-ID: <319754bb62fb676748715d86e7996141@codeaurora.org>
X-Sender: taozha@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-16 22:47, Mike Leach wrote:
> Hi
> 
> On Fri, 16 Apr 2021 at 15:16, <taozha@codeaurora.org> wrote:
>> 
>> On 2021-04-16 19:23, Alexander Shishkin wrote:
>> > Tao Zhang <taozha@codeaurora.org> writes:
>> >
>> >> Add property "coresight-name" for coresight component name. This
>> >> allows coresight driver to read device name from device entries.
>> >>
>> >> Signed-off-by: Tao Zhang <taozha@codeaurora.org>
>> >> ---
>> >>  Documentation/devicetree/bindings/arm/coresight.txt | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt
>> >> b/Documentation/devicetree/bindings/arm/coresight.txt
>> >> index d711676..0e980ce 100644
>> >> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> >> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> >> @@ -103,6 +103,8 @@ its hardware characteristcs.
>> >>        powers down the coresight component also powers down and loses its
>> >>        context. This property is currently only used for the ETM 4.x
>> >> driver.
>> >>
>> >> +    * coresight-name: the name of the coresight devices.
>> >
>> > Which devices? Also, is it a common practice to extend device tree
>> > definitions based on arbitrary driver needs, or should there be some
>> > sort of a discussion first?
>> >
>> > Regards,
>> > --
>> > Alex
>> Through the device tree entries, we can define their own name for any
>> coresight device. This design is mainly used to facilitate the unified
>> naming of coresight devgies across targets. e.g, without this patch, 
>> we
>> can only see from sysFS there are multiple funnels, but we cannot know
>> which funnel it is based on their names from sysFS. After applying 
>> this
>> patch, we can directly know what device it is by observing the device
>> name in sysFS. And the common scripts can be developed, since applying
>> this patch, the same coresight device can have the same name across
>> targets. Each developer or vendor can define the name of each 
>> coresight
>> device according to their preferences and products.
>> 
>> Tao
> 
> 1) I am concerned that this will break the existing protocol which
> associates a fixed device type name + number with each device - i.e.
> etm0, funnel1 etc.
> This naming convention allows for generic common scripts to be 
> developed - see:
> ./tools/perf/tests/shel/test_arm_coresight.sh
> This relies on the device type prefixes to iterate across all devices
> in a system - and uses the connections links that are present in each
> of the devices to determine the topology.
> Replacing these with arbitrary names will break existing scripts.
> 
Yes, agree with you. The patch should not break the existing protocol.
> 2) Using the current system it is entirely possible to determine which
> specific device a given name relates to.
> e.g. ls -al /sys/bus/coresight/devices/
> 
> lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_cpu0 ->
> ../../../devices/platform/soc/858000.cti/cti_cpu0
> lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_cpu1 ->
> ../../../devices/platform/soc/859000.cti/cti_cpu1
> lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_cpu2 ->
> ../../../devices/platform/soc/85a000.cti/cti_cpu2
> lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_cpu3 ->
> ../../../devices/platform/soc/85b000.cti/cti_cpu3
> lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_sys0 ->
> ../../../devices/platform/soc/810000.cti/cti_sys0
> lrwxrwxrwx 1 root root 0 Apr 14 19:02 cti_sys1 ->
> ../../../devices/platform/soc/811000.cti/cti_sys1
> lrwxrwxrwx 1 root root 0 Apr 14 19:02 etm0 ->
> ../../../devices/platform/soc/85c000.etm/etm0
> lrwxrwxrwx 1 root root 0 Apr 14 19:02 etm1 ->
> ../../../devices/platform/soc/85d000.etm/etm1
> lrwxrwxrwx 1 root root 0 Apr 14 19:02 etm2 ->
> ../../../devices/platform/soc/85e000.etm/etm2
> lrwxrwxrwx 1 root root 0 Apr 14 19:02 etm3 ->
> ../../../devices/platform/soc/85f000.etm/etm3
> lrwxrwxrwx 1 root root 0 Apr 16 14:17 funnel0 ->
> ../../../devices/platform/soc/821000.funnel/funnel0
> lrwxrwxrwx 1 root root 0 Apr 16 14:17 funnel1 ->
> ../../../devices/platform/soc/841000.funnel/funnel1
> lrwxrwxrwx 1 root root 0 Apr 16 14:17 replicator0 ->
> ../../../devices/platform/soc/824000.replicator/replicator0
> lrwxrwxrwx 1 root root 0 Apr 16 14:17 tmc_etf0 ->
> ../../../devices/platform/soc/825000.etf/tmc_etf0
> lrwxrwxrwx 1 root root 0 Apr 16 14:17 tmc_etr0 ->
> ../../../devices/platform/soc/826000.etr/tmc_etr0
> lrwxrwxrwx 1 root root 0 Apr 16 14:17 tpiu0 ->
> ../../../devices/platform/soc/820000.tpiu/tpiu
> 
> Further topology can be determined using the connections sub-directory
> in each device:-
> 
> ls -al  /sys/bus/coresight/devices/etm0/connections/out\:0
> lrwxrwxrwx 1 root root 0 Apr 16 14:18
> /sys/bus/coresight/devices/etm0/connections/out:0 ->
> ../../../841000.funnel/funnel1
> 
> Using this information it is possible to iterate across the entire
> topology of any coresight system.
> 
Yes, these information can iterate across the entire topology of any 
coresight
system. But it cannot quickly identify specific coresight devices across 
targets.
e.g. If there are a lot of cti on one target, we need to identify the 
cti by its
register address. The same function cti may has different register 
address across
targets. This patch allow the same function coresight device has the 
same name,
and it could be operated by scripts easily.
> 3) If there is some scripting requirement that cannot be solved with
> the information available above - then it would be better to add this
> name as an alias rather than a direct replacement.
> Therefore any coresight device could have an alias_name entry, that
> could be interrogated by a script and used as required. This avoids
> breaking any existing scripts using the established naming convention.
> 
Agree with you. Can I use sysfs_create_link to create a kernel link 
between
alias name and coresight device kobject? At the same time, the original
coresight device naming method remains unchanged. Thus, the existing 
protocol
will not be broken.
Or is there any better suggeston on how to add alias name for coresight 
device?
> 4) Any devicetree attribute should follow the <owner>,<attribute>
> naming convention. e.g. arm,some_attribute.
> I agree with Alex that it may not be normal practice to add in
> attributes in these circumstances - this does not appear to relate to
> a specific hardware feature or limitation. You may wish to discuss
> this with the device tree maintainers.
> 
> Thanks and Regards
> 
> Mike
Sure. I will update this according to your suggestion on patch v2.

Best.
Tao
