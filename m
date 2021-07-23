Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB04D3D4087
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 21:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhGWS1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 14:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhGWS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 14:27:02 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C28C061575;
        Fri, 23 Jul 2021 12:07:36 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso2187800ota.13;
        Fri, 23 Jul 2021 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/HO6+phJGX3lelq6t157Nbhv6ZLIzzcuXXmzn8gV64k=;
        b=sFgt2eHfugv0KyuFTRnIZcY2+r7kPfQ02E6Fq/99y6A7LVKeLh/1y07mP8k522o5lL
         tEA8EI/6RAONS36hjr71uNh2vWfE5nQCuQHvGQkBLbDayJQbgvGq2uJQLXjnwrLJo5Dk
         8dz5svmE7eqkSBX3zRaKX2swck0uIeBp+yswdhjpWJTQfszUzWqc2w5YpuSZ2BgNb18f
         vgKbiDevJAamAEqnBXRh6+INbGSOtNACN6n7sOvUHvRZUKAk2XPge4lOEafz3qtfia5K
         Pwj+1DttV7Ghq8RSPdlScqz+/cAwQvfcRhajpaemezIuv1KmWSYJ2+FS2OMjGUvRzFNp
         dHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HO6+phJGX3lelq6t157Nbhv6ZLIzzcuXXmzn8gV64k=;
        b=DjWy4Qz+Sqr3o+7lp87nX3J3C7/YLW9Ec9QelLtWN+4eUkXCGZMh8iO6OxzJUG3cDv
         YI3tMJkl2/lwv28Hw0WWniyJ8NNotF2B88RLtjd///AM778KsjWvGsd+SOP49VW27IGY
         2YnHfS6xvhkG1OkdCayEs8qdGl1SE7Fr/UbfRt9BsSfbIbzpHS4D8W9DP6Ew5gmlc1fW
         zc03BtgM/GwGfIIiacBFxiUECP0S4PnHvVM+TaXSHqCUByGslR3QcB/2qXliDpe70+tN
         VM71yfX9auEyHkfVVt2550dEiGIzSPzgJUS8+nQVaJBj66uklxXtJrdGwEpiARKAFQXu
         uhCg==
X-Gm-Message-State: AOAM530mWb1IKPp8DsTotKLmmOYPzuFwz7p33JuM+erC7+AEZW5ys48D
        ftF5FuNHvpoa504fnpS1y3c4PJWQuAE=
X-Google-Smtp-Source: ABdhPJzeI4Mi77IefqObLdXaAkxJsEBtPf9A+KB/fCok66OreMmJ0OZxyGNaW+xOdiYvsXof8/z6CQ==
X-Received: by 2002:a9d:c67:: with SMTP id 94mr4013908otr.344.1627067255181;
        Fri, 23 Jul 2021 12:07:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s24sm4487667ooq.37.2021.07.23.12.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 12:07:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210716093916.1516845-1-kyletso@google.com>
 <CAGZ6i=3PJ+aRzM7=c6f9oCaCjvdQ7GqtCn+dv7H0yC8WMoe+KA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] usb: typec: tcpm: Support non-PD mode
Message-ID: <66b76646-3c40-fb12-6678-6542c10caaa9@roeck-us.net>
Date:   Fri, 23 Jul 2021 12:07:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGZ6i=3PJ+aRzM7=c6f9oCaCjvdQ7GqtCn+dv7H0yC8WMoe+KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/21 10:18 AM, Kyle Tso wrote:
> On Fri, Jul 16, 2021 at 5:39 PM Kyle Tso <kyletso@google.com> wrote:
>>
>> tcpm.c could work well without PD capabilities. Do not block the probe

"could" is a bit vague. What is the use case ?

>> if capabilities are not defined in fwnode and skip the PD power
>> negotiation in the state machine.
>>
>> Signed-off-by: Kyle Tso <kyletso@google.com>
>> ---
> 
> Hi, any comments about this patch?
> 

First question would be if this is documented/standardized. More comments below.

> thanks,
> Kyle
> 
>>   drivers/usb/typec/tcpm/tcpm.c | 50 ++++++++++++++++++++---------------
>>   1 file changed, 29 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index 5b22a1c931a9..a42de5e17d24 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -3914,6 +3914,8 @@ static void run_state_machine(struct tcpm_port *port)
>>                  if (port->ams == POWER_ROLE_SWAP ||
>>                      port->ams == FAST_ROLE_SWAP)
>>                          tcpm_ams_finish(port);
>> +               if (!port->nr_src_pdo)
>> +                       tcpm_set_state(port, SRC_READY, 0);
>>                  port->upcoming_state = SRC_SEND_CAPABILITIES;
>>                  tcpm_ams_start(port, POWER_NEGOTIATION);
>>                  break;
>> @@ -4161,7 +4163,10 @@ static void run_state_machine(struct tcpm_port *port)
>>                                  current_lim = PD_P_SNK_STDBY_MW / 5;
>>                          tcpm_set_current_limit(port, current_lim, 5000);
>>                          tcpm_set_charge(port, true);
>> -                       tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
>> +                       if (!port->nr_snk_pdo)
>> +                               tcpm_set_state(port, SNK_READY, 0);
>> +                       else
>> +                               tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
>>                          break;
>>                  }
>>                  /*
>> @@ -5939,15 +5944,17 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>>
>>          /* Get source pdos */
>>          ret = fwnode_property_count_u32(fwnode, "source-pdos");
>> -       if (ret <= 0)
>> -               return -EINVAL;
>> +       if (ret < 0)
>> +               ret = 0;
>>

This makes the capability properties optional. I think that would have
to be documented.

>>          port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
>> -       ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
>> -                                            port->src_pdo, port->nr_src_pdo);
>> -       if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
>> -                                           port->nr_src_pdo))
>> -               return -EINVAL;
>> +       if (port->nr_src_pdo) {
>> +               ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
>> +                                                    port->src_pdo, port->nr_src_pdo);
>> +               if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
>> +                                                   port->nr_src_pdo))
>> +                       return -EINVAL;
>> +       }
>>
>>          if (port->port_type == TYPEC_PORT_SRC)
>>                  return 0;
>> @@ -5963,19 +5970,21 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>>   sink:
>>          /* Get sink pdos */
>>          ret = fwnode_property_count_u32(fwnode, "sink-pdos");
>> -       if (ret <= 0)
>> -               return -EINVAL;
>> +       if (ret < 0)
>> +               ret = 0;
>>
>>          port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
>> -       ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
>> -                                            port->snk_pdo, port->nr_snk_pdo);
>> -       if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
>> -                                           port->nr_snk_pdo))
>> -               return -EINVAL;
>> +       if (port->nr_snk_pdo) {
>> +               ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
>> +                                                    port->snk_pdo, port->nr_snk_pdo);
>> +               if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
>> +                                                   port->nr_snk_pdo))
>> +                       return -EINVAL;
>>
>> -       if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
>> -               return -EINVAL;
>> -       port->operating_snk_mw = mw / 1000;
>> +               if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
>> +                       return -EINVAL;
>> +               port->operating_snk_mw = mw / 1000;
>> +       }
>>
>>          port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
>>
>> @@ -6283,9 +6292,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>>          int err;
>>
>>          if (!dev || !tcpc ||
>> -           !tcpc->get_vbus || !tcpc->set_cc || !tcpc->get_cc ||
>> -           !tcpc->set_polarity || !tcpc->set_vconn || !tcpc->set_vbus ||
>> -           !tcpc->set_pd_rx || !tcpc->set_roles || !tcpc->pd_transmit)
>> +           !tcpc->get_vbus || !tcpc->set_cc || !tcpc->get_cc || !tcpc->set_polarity ||
>> +           !tcpc->set_vconn || !tcpc->set_vbus || !tcpc->set_roles)

With this change, if a driver does not define the necessary pd callbacks
(set_pd_rx, pd_transmit), but its devicetree data does provide pdo properties,
we'll get a nice crash.

On top of that, I am quite sure that the set_pd_rx() callback is still called
from various places even if neither sink-pdos nor source-pdos properties
are defined.

I think this really tries to handle two conditions: A low level driver that
doesn't support PD, and a system where the low level driver does support PD
but the system itself doesn't. And then there is the odd case where the system
only supports either source or sink PD while claiming to support the other.
Maybe it would make sense to separate both conditions, for example by introducing
a new flag such as pd_supported to indicate that the system doesn't support the
PD protocol.

Guenter

>>                  return ERR_PTR(-EINVAL);
>>
>>          port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>> --
>> 2.32.0.402.g57bb445576-goog
>>

