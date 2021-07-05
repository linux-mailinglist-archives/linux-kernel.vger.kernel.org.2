Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11FC3BB8F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhGEIXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhGEIXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1CE761447;
        Mon,  5 Jul 2021 08:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625473241;
        bh=LFyp+REsgurXPkNsy24a7z98TwA4hJdMX8wTWIyMHYI=;
        h=From:To:Cc:Subject:Date:From;
        b=jHnVtFcWj6+aYiacfOiLgjmuzr/pP+FzjjT2ElJMLh5NgqsMZODGWQ9uv2VEkWTdN
         QiW8bd3Nz/3fOMW21eS22ZpnYPm/H0yrNAXNQSS+TSH0pwCbsQ1ysalm1IUj4yOJQ/
         znaxZnbTFtnj2qJXh/K1RU+/F6AdkW2CLibxHPZc7JnearEqTqzLEPkP12n2pcMCpP
         +C/rIklajMRqwkYE324NpBG1XPFWnZiIEmScqC8baKVipRfUxH1Vg94agoykBaCHKt
         7sL8TN/InJiyJs6peCEigv0KaFReUvqNyAeCY1pKzt0h+jbunMf/D0Vkaw8Dg/EwQY
         EIgNR6hJrp5IQ==
Received: from johan by xi with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1m0JqE-0004ln-9v; Mon, 05 Jul 2021 10:20:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] USB: serial: cp210x: fixes and CP2105/CP2108 fw version
Date:   Mon,  5 Jul 2021 10:20:09 +0200
Message-Id: <20210705082015.18286-1-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are couple of minor fixes and some cleanups related to the recent
regression which broke RTS control on some CP2102N devices with buggy
firmware.

In case we run into another one of these, let's log the firmware
version also for CP2105 and CP2108 for which it can be retrieved.

Johan


Changes in v2
 - keep the special-chars error message to make it more obvious that
   continuing on errors is intentional (1/6) (Greg)


Johan Hovold (6):
  USB: serial: cp210x: fix control-characters error handling
  USB: serial: cp210x: fix flow-control error handling
  USB: serial: cp210x: clean up control-request timeout
  USB: serial: cp210x: clean up set-chars request
  USB: serial: cp210x: clean up type detection
  USB: serial: cp210x: determine fw version for CP2105 and CP2108

 drivers/usb/serial/cp210x.c | 77 +++++++++++++++----------------------
 1 file changed, 32 insertions(+), 45 deletions(-)

-- 
2.31.1

