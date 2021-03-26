Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF5834B231
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCZWeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhCZWdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:33:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A308C0613AA;
        Fri, 26 Mar 2021 15:33:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so4928551pjh.1;
        Fri, 26 Mar 2021 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfe8aSppDXkPqJOlKfc1dOMa01ZR+nc0EiEZ+WQq/Yc=;
        b=dKj20F7iQ1lChMAlm86D4iiriOmrbwdDLLU0pOfqcFWJFOGhlt1s6C6T0E0S5WgOQo
         5U9xrtoflreP9RxnyYPAUAy2LmBms13qaeiPCcXqDb+MlOIJC6f5SAS4jE3g1hZ+uz6e
         cdiTWWkUuydA9dg5e3SGSVGTfIX0XdPeCHeYJRhDuIBWMBSkTPHmeqVTp9FjgQ5oEa7b
         MQ+7jICsE/GqTKWfn60u+EJTqu2O9tf1k7Pqox+PTtQqM9yQ3yxw8kFzU98nuMQ0+ix7
         qOAocJUuo8F3DSRl2/hHiS9v/cdFtBnqLgHmbwWn/57WM9PsFwmWMclRPUFCIpFY1kBx
         zwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfe8aSppDXkPqJOlKfc1dOMa01ZR+nc0EiEZ+WQq/Yc=;
        b=TVtXDNJtNCPM7SjMavytvjCUGPudN+yEuoHwlA59WUz9hRiNsfc8Kdl70UKBG8BwAG
         lzspviPMFi/uZgvnVWfGJ9pLpkLteJoj5L3R54PDv4klWiGMQHTvbGY8IgmY4ZNPdeGW
         d4acG264VCfyjJo2SUFXz5G5xdqAMHejkQViATaeyFRvOCr/aYyHDA44yiNUyQNLd/Yg
         5BQpwENtJsFAIZ38BuWekm/Zw0MuIZPa9VvXGFqtDAKYEhI01urrfnQ92twWhkTRcXoJ
         28jYOcHimnxoDSBsOgPUGPqL9idl0MTWF5reOHfPXwBKhakurkUu82vtTIDfXl4wxmvL
         XOxQ==
X-Gm-Message-State: AOAM530FozHh0sOspJSheMU0aUJHLvo03MZnGufdkvzy36TDDObuy6KH
        fI7kJkTeQHIRlPB9GCxuIy8=
X-Google-Smtp-Source: ABdhPJx0OCPdF/JxlFKv+YnYYcyYd4zjjbCeoufHZl8wyzHvZjmehaY9GCTf0uZeJY8+kV9PG2/x6A==
X-Received: by 2002:a17:902:b94c:b029:e6:98b9:c15b with SMTP id h12-20020a170902b94cb02900e698b9c15bmr17766210pls.60.1616798019651;
        Fri, 26 Mar 2021 15:33:39 -0700 (PDT)
Received: from localhost.localdomain ([49.207.194.205])
        by smtp.gmail.com with ESMTPSA id c193sm10136262pfc.180.2021.03.26.15.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 15:33:39 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Peter Chen <peter.chen@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] drivers: usb: misc: update to use usb_control_msg_{send|recv}() API
Date:   Sat, 27 Mar 2021 04:02:48 +0530
Message-Id: <20210326223251.753952-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_{send|recv}() API provides a more convenient way
of using usb_control_msg() in some usecases. Using this, short reads are
considered as errors, data can be used off the stack, and the need for
the calling function to create a raw usb pipe is eliminated.
This patch series aims to update existing instances of usb_control_msg() 
in drivers/usb/misc/* to usb_control_msg_{send|recv}() appropriately
wherever it would be a good fit, and also update the return value
checking mechanisms in place (if any), as necessary so nothing breaks.

Changes in v4:

  * Drop all proposed changes to drivers (from v3) where the new API
    doesn't fit appropriately.
  * Update commit messages.
  * Link to v3:
      https://lore.kernel.org/linux-usb/YBF9exziI12OCSuA@hovoldconsulting.com/T/#m269ab33b52331c134bbbc77d13cb65c2194a6093

Changes in v3:

  * idmouse, emi26 and emi62 are left unchanged, and are not updated.
    -> since control transfers in idmouse are without a data stage, there's no
       real advantage in using the new helper here.
    -> in emi26, and emi62, FW_LOAD_SIZE = 1048 (> 1024). Thus, if we try to use the
       new helpers, it will result in either build warnings, or memory being allocated.

  * Link to v2:
      https://lore.kernel.org/linux-usb/20201130013103.2580467-1-anant.thazhemadam@gmail.com/T/


Changes in v2:

  * Buffer variables that were previously dynamically allocated are no
    longer dynamically allocated unless they have a variable length
    (since that threw a warning).

  * Link to v1:
        https://lore.kernel.org/linux-usb/20201129160612.1908074-1-anant.thazhemadam@gmail.com/ 



Anant Thazhemadam (3):
  usb: misc: ehset: update to use the usb_control_msg_{send|recv}() API
  usb: misc: ezusb: update to use usb_control_msg_send()
  usb: misc: usbsevseg: update to use usb_control_msg_send()

 drivers/usb/misc/ehset.c     | 76 +++++++++++++++---------------------
 drivers/usb/misc/ezusb.c     | 16 +-------
 drivers/usb/misc/usbsevseg.c | 60 ++++++++--------------------
 3 files changed, 51 insertions(+), 101 deletions(-)

-- 
2.25.1

