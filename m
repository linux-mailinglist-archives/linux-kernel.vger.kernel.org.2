Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA13423552
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 03:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhJFBES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 21:04:18 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:34484 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230218AbhJFBER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 21:04:17 -0400
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5DF31180DF721;
        Wed,  6 Oct 2021 01:02:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 52D9018A608;
        Wed,  6 Oct 2021 01:02:24 +0000 (UTC)
Message-ID: <35a358c67c6220825b37e64c6aa2978741565bdd.camel@perches.com>
Subject: Re: [PATCH v2] staging: r8188eu: Fix misspelling in comment
From:   Joe Perches <joe@perches.com>
To:     "Siou-Jhih, Guo" <hallblazzar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 05 Oct 2021 18:02:22 -0700
In-Reply-To: <f1569e97-8996-e538-182c-cc5f6510dc35@gmail.com>
References: <7bc392d5-11e4-7ad0-dab6-295ccadf63b9@gmail.com>
         <YVwpEa5T4HnOX5/g@kroah.com>
         <f1569e97-8996-e538-182c-cc5f6510dc35@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 52D9018A608
X-Spam-Status: No, score=0.03
X-Stat-Signature: did5ktcsude1wpognowhts9fsc58zaz8
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19i4mQEPjDli2/8f8gwqFKRCAmqH/tGfDI=
X-HE-Tag: 1633482144-645194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-05 at 22:16 +0100, Siou-Jhih, Guo wrote:
> If anything should I additionally aware, I'd like to fix them.

Maybe fix these too?

$ git grep -w -i -P -n 'issuign|fittign|settign|enablign|followign|chargign|beign|startign|accordign|runnign'
arch/arm/mach-s3c/sleep-s3c64xx.S:33:    * requires to get the kernel runnign again. This code expects to be
drivers/crypto/ccree/cc_driver.c:278:   /* AXI interrupt config are obsoleted startign at cc7x3 */
drivers/hid/hid-thrustmaster.c:80: * beign conducted yet. The position and meaning of fields are a
drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h:809: * our own HELLO may get lost if it happens right as the MASTER is issuign a
drivers/net/ethernet/qlogic/qede/qede_filter.c:2029:    /* Translate the flow specification into something fittign our DB */
drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:1158: * Overview:   88E change all channel tx power accordign to flag.
drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:1837: * Overview:   88E change all channel tx power accordign to flag.
drivers/power/supply/ab8500_charger.c:1325: * ab8500_charger_led_en() - turn on/off chargign led
drivers/power/supply/ab8500_charger.c:1327: * @on:              flag to turn on/off the chargign led
drivers/spi/spi-tegra20-slink.c:543:            /* HW need small delay after settign Packed mode */
drivers/staging/media/atomisp/pci/runtime/bufq/src/bufq.c:412:   * by some test apps. Enablign logging here floods the log
drivers/staging/media/atomisp/pci/runtime/bufq/src/bufq.c:434:   * by some test apps. Enablign logging here floods the log
drivers/staging/r8188eu/core/rtw_ap.c:747:Set to 0 (HT pure) under the followign conditions
drivers/staging/r8188eu/hal/HalPhyRf_8188e.c:72: * Overview:    88E change all channel tx power accordign to flag.
drivers/thermal/tegra/soctherm.c:844:    * programmed on a different one. This beign a LEVEL interrupt won't
drivers/usb/gadget/function/f_hid.c:312:         * Remove this from list to protect it from beign free()
net/mac80211/mesh_plink.c:1077:                  * B's peer link establishment or B beign


