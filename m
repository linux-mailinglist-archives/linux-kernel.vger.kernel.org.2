Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7D43D8A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhG1J3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhG1J3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:29:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D865C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:29:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n192-20020a25dac90000b029054c59edf217so2189517ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1khUy18ueI16YW+V4Jc14xqEcfZYqzU/8GyELBFAS70=;
        b=DadcpphUiTQazdJ6fmCJPl6deN3oInvudZoTj8JXeLCALHLrZ+Jfa0Z3IpCZTWBol6
         0n/wx1dUPDhaKe8gZJXqsWTOUq2iQptnGrnqp+k2I7QqIjKRbRPFrAbDVlCZ7Oy3jt6l
         9lYbrirHb2e5P5/Iu4BBcpk10huickNhchZlt15skBah1Nhv8p9uTqzPT6xQmvy9H1wD
         +abOkcSLYB3w/JUImFI9coeZo98OLewAVm83jtGghmL9azYMraJhP0//Nos9EkkpXzhe
         l7EgmrExNownBurnaoauJmL6aZ2nrWbbxDa1uGv5iROfOcDrKyUJzgErXoXXVC4mFdWZ
         imnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1khUy18ueI16YW+V4Jc14xqEcfZYqzU/8GyELBFAS70=;
        b=mvlPftV0kej2W5ywUfXNEsFz7DWjcY/n/h8FaPRxeL0MuEVEqZRqJLT7AEHrmdCv0N
         +CyAcw5mLhIX0FV7dyuZjKxAAVrwTjCgxVZaFlXQW/kl3ksHELnuWAMGmXMdVVb6MpFi
         5NGNiraVjkrlK3uWvazLp/L8ms3C2QZ8gLa+ZLN9I0qDm7PXxi7OPTwEK5w3tQUlW9aA
         +i63XvWfG2iT3uePO8EtRt+21yBo8TzvMMyErm/dWFyU4SV4+4Jqa/oDGr3jDUeN+VJc
         DRkWeVpELyq/km54YxUP/Qpv++HLa9CTPhyLsF3EgljwhB6ds71AZluZLsIUKrbEIrG1
         ip+w==
X-Gm-Message-State: AOAM530THNu6ZTLvp5dYHUlGuqtf9sAO6PDYFuV5gOcSWt5510EfPKFI
        tAdnxaTrX3y5KWVvWEl78V8F98UEsYVS
X-Google-Smtp-Source: ABdhPJypDqZj7uR8D0hzK+n0Ux+pDHdR1EDUrSPeoXyPZk3gbgck9IOjubpQeXerHynZM7yjX6o37c72xazU
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:da7f:a21b:ee74:66a2])
 (user=kyletso job=sendgmr) by 2002:a05:6902:1507:: with SMTP id
 q7mr37741267ybu.326.1627464577344; Wed, 28 Jul 2021 02:29:37 -0700 (PDT)
Date:   Wed, 28 Jul 2021 17:29:28 +0800
Message-Id: <20210728092930.2552619-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 0/2] TCPM non-pd mode
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason for this patch is to let the device/system policy decide
whether PD is going to be supported using devicetree properties.
                                                                                                    
A new dt property "pd-unsupported" is introduced and TCPM uses this
property as a flag to decide whether PD is supported. If the flag is
false (the dt property is not present), the RX functionality of the
low-level driver will not be enabled. The power negotiation related
states will be skipped as well. If the flag is true, everything is as
what it was before.                                                  
                                                                                                    
If "pd-unsupported" is present, and the port is SRC or DRP, another                               
existing dt property "typec-power-opmode" needs to be specified to                                  
indicate which Rp value should be used when the port is SRC.                                        
                                                                                                    
changes since v2:
- Negated the meaning and the name of the dt property. Now the name is
  "pd-unsupported"
- Changed the control flow if the port is SNK or DRP. Return directly if
  the flag is false (PD not supported). Read "self-powered" before that.

---
cover-letter in v2:
---
The reason for this patch is to let the device/system policy decide                                 
whether PD is going to be supported using devicetree properties.                                    
                                                                                                    
A new dt property "pd-supported" is introduced and TCPM uses this                                   
property as a flag to decide whether PD is supported. If the flag is                                
false, the RX functionality of the low-level driver will not be enabled.                            
The power negotiation related states will be skipped as well. If the                                
flag is true, everything is as what it was before.                                                  
                                                                                                    
If "pd-supported" is not present, and the port is SRC or DRP, another                               
existing dt property "typec-power-opmode" needs to be specified to                                  
indicate which Rp value should be used when the port is SRC.                                        
                                                                                                    
changes since v1:                                                                                   
- revise the patch to use dt properties

Kyle Tso (2):
  dt-bindings: connector: Add pd-supported property
  usb: typec: tcpm: Support non-PD mode

 .../bindings/connector/usb-connector.yaml     |  4 +
 drivers/usb/typec/tcpm/tcpm.c                 | 88 +++++++++++++++----
 2 files changed, 74 insertions(+), 18 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog

