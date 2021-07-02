Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8E43BA1BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhGBNxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbhGBNxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:53:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3016AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:51:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p8so12583516wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wrOZybgukP7D16uiDrPNpCD/cJbRSW0NaJbDD2oK04Y=;
        b=rrp4PRCFayeplVQW0DnmjV0ylYODHlmBAyoKKgoR0P9fIMUHr7B1t+EV7Q4NIlbOJV
         vdvx8pQ7VetP0dFHSzvX1S2C8fl0R/RKFMXt8zkFYO57osJbPMdpErKjO76zMi0HrgHC
         z8JtiHNOQ4hP8kRbLGmiHZTmtlfQtg0d9Pyyox6VaqMt2iauA3kq4a/yXdxUcNcTpE0S
         7+/Cc6roPntwm8+X9YCE/JXe+JlHNb/cLQIoSeexnoBnQ3iYRThBTwlRNFkbA2LIwXCL
         Fh3kd9d3BkC5EIK4Yio5CPeSygmd0OY/p+adpg9CU7RiMyghDQxlELX+zHquBCedz1Pk
         ahjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wrOZybgukP7D16uiDrPNpCD/cJbRSW0NaJbDD2oK04Y=;
        b=raNL98+Bvfd6UBFMlpkNRNrf4M/aG7lZerSZjpNIFn1WpzQihgKIvdMMroHs5quXtH
         3eebNGbtElwXgP1guX1tYQdssHyliyJO+aLeBGq4u2ZYMZclpeLLsL2aBq3NbjJ73FZ4
         bQy34+lDVzjta5ow+ZLjt0FWHwNPsoHp3mMjeP1jKhcYdmxbzBHS/IBz3FKWxl8NfmI7
         4gK2RAMPRw8keUqrr6rOsdaDN3+cC2+CRhlmqdzgpbBdjPQoCCA+HYHgUiq8pkeHro5i
         z4WfAM36Mi5SdIwtwXMmg3jTfqccu9+cA9YCxaYDl8zD65c3f/AHTYmAlK2lQdH6a67F
         ++vQ==
X-Gm-Message-State: AOAM531K5ok9Mjp8aW3H92b3mWj9tmm5VVLaVD/aMIyIEaB7AAolUrBw
        BSX1t2xG8yl/jTntEGK0Q94RjJ3tu5I3/SFJ
X-Google-Smtp-Source: ABdhPJzILwySjU7JK7lzJF8ppkoPs5SkCRTaMo18wSL5fvjT/vBOVxE58eo+YGp0lvrOOUkNuI/NFw==
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr6040892wru.220.1625233869580;
        Fri, 02 Jul 2021 06:51:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d90f:6b1d:481f:d5e7? ([2a01:e34:ed2f:f020:d90f:6b1d:481f:d5e7])
        by smtp.googlemail.com with ESMTPSA id t17sm3057581wmi.47.2021.07.02.06.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 06:51:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFD] DTPM hierarchy description via DT
Message-ID: <847aca40-2ded-8e37-72bf-c38ccbdc28e5@linaro.org>
Date:   Fri, 2 Jul 2021 15:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

recently a new framework based on top of the powercap framework was
introduced to limit the power of some devices when they are capable of
that. Based on the approximate power numbers from the energy model, it
allows to have a rough estimation of the power consumption and set the
power limit [1].

This framework describes via a hierarchy the constraints relationship
between all those devices and it is SoC specific.

The problem is how to describe this hierarchy.

The hierarchy could be like:

soc


   |


   |-- package


   |      |


   |      |-- cluster0


   |      |      |


   |      |      |-- cpu0


   |      |      |


   |      |      |-- cpu1


   |      |      |


   |      |      |-- cpu2


   |      |      |


   |      |      `-- cpu3


   |      |


   |      |-- cluster1


   |      |      |


   |      |      |-- cpu4


   |      |      |


   |      |      `-- cpu5


   |      |


   |      `-- gpu


   |


   |-- memory


   |      |


   |      |-- bank0


   |      |


   |      `-- bank1


   |


   |-- multimedia


   |      |


   |      |-- camera


   |      |


   |      `-- dsp


   |


   |-- modem


   |


   `-- screen




We are far from this description yet but it is for illustration purpose.

All the nodes of the tree do not necessarily reflect real devices, for
example, 'package' or 'multimedia' are not described in the DT.

What we want is to build this hierarchy which is SoC dependent.

A first proposal was made to create those nodes in configfs but because
it results in creating a node in sysfs also the approach is not valid [2]

It was suggested to use the devicetree to describe such hierarchy. There
are several possibilities but the nodes not describing real hardware
above is difficult to describe. Also, the hierarchy should not be over
complexified.

On the other hand most of the devices are already described, so it is a
question of tightening them together.

There are different possibilities to describe this hierarchy:

1. Create the hierarchy in the DT:

	power-zones {

		package {

			big {
				powerzone = <&cpu_b0 POWERZONE_DVFS>,
					<&cpu_b1 POWERZONE_DVFS>;
			};

			little {
				powerzone = <&cpu_l0 POWERZONE_DVFS>,
					<&cpu_l1 POWERZONE_DVFS>,
					<&cpu_l2 POWERZONE_DVFS>,
					<&cpu_l3 POWERZONE_DVFS>;
			};

			gpu {
				powerzone = <&gpu POWERZONE_DVFS>;
			};
		};
	};

2. Let the kernel build the hierarchy but add a property in the
different nodes:

https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=powercap/dtpm-dts-1.0&id=05943f5a1cf33df36dbe423fd4b549a9aa244da1

And from there the kernel does for_each_node_with_property(). The kernel
has to know "cpu-pd0" and "cpu-pd1". That implies a per soc
initialization code:

https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=powercap/dtpm-dts-1.0&id=7525abb234695d07a0094b2f511d5fe8bea0a979

https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=powercap/dtpm-dts-1.0&id=70e1deb642a939d14dd9b0391d8219cf21a03253


3. An intermediate description between 1. and 2.

The nodes have a property which is a phandle to the parent node. But if
the parent node does not exists, create an empty and point to it.

package {
	powerzone;
	powerzone-parent = <&soc>;
};

cluster0 {
	powerzone-parent = <&package>;
};

	...

		cpu_l0: cpu@0 {
			device_type = "cpu";
			compatible = "arm,cortex-a53";
			reg = <0x0 0x0>;
			enable-method = "psci";
			capacity-dmips-mhz = <485>;
			clocks = <&cru ARMCLKL>;
			#cooling-cells = <2>; /* min followed by max */
			dynamic-power-coefficient = <100>;
			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
			powerzone-parent = <&cluster0>;
		};

	...

I implemented 1. and 2. but before going forward and writing the yaml
bindings which are time consuming, it would be preferable we agree on
something instead of having to drop the code again and again.

Thanks for your comments


[1] https://lwn.net/Articles/839318/
[2] https://www.spinics.net/lists/kernel/msg3891770.html

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
