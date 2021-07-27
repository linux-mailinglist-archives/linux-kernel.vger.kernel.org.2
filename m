Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2413D7330
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhG0K2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:28:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37196 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236036AbhG0K2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:28:18 -0400
X-UUID: efd200f13da7478b88155cd429614a1f-20210727
X-UUID: efd200f13da7478b88155cd429614a1f-20210727
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chihhao.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 521133217; Tue, 27 Jul 2021 18:28:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 18:28:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Jul 2021 18:28:13 +0800
From:   <chihhao.chen@mediatek.com>
To:     <geraldogabriel@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <chihhao.chen@mediatek.com>,
        <damien@zamaudio.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <tiwai@suse.com>, <tiwai@suse.de>, <wsd_upstream@mediatek.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
Date:   Tue, 27 Jul 2021 18:27:44 +0800
Message-ID: <20210727102744.30364-1-chihhao.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAEsQvctJDnsaRTXAGAJ6==juKazoo2=AJrWabLzqE=jCfg5EEA@mail.gmail.com>
References: <CAEsQvctJDnsaRTXAGAJ6==juKazoo2=AJrWabLzqE=jCfg5EEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chihhao chen <chihhao.chen@mediatek.com>

Hello

<6>[  150.347456][ T2768] __uac_clock_find_source: FOR EP 81: Clock Selector c has pin 2 for Clock Source ID a selected
<6>[  150.347517][ T2768] __uac_clock_find_source: FOR EP 81: Found Source! Clock Selector c has pin 2 for Clock Source ID a about to be reselected
<6>[  150.384289][ T2768] __uac_clock_find_source: FOR EP 81: Clock Selector c has pin 2 for Clock Source ID a selected
<6>[  150.390920][ T2768] __uac_clock_find_source: FOR EP 81: Found Source! Clock Selector c has pin 2 for Clock Source ID a about to be reselected
<6>[  150.438156][ T2768] __uac_clock_find_source: FOR EP 81: Clock Selector c has pin 2 for Clock Source ID a selected
<6>[  150.438226][ T2768] __uac_clock_find_source: FOR EP 81: Found Source! Clock Selector c has pin 2 for Clock Source ID a about to be reselected
<6>[  150.473547][ T2768] __uac_clock_find_source: FOR EP 81: Clock Selector c has pin 2 for Clock Source ID a selected
<6>[  150.480165][ T2768] __uac_clock_find_source: FOR EP 81: Found Source! Clock Selector c has pin 2 for Clock Source ID a about to be reselected
<6>[  150.513375][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
<6>[  150.513439][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
<6>[  150.546161][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
<6>[  150.552678][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
<6>[  150.584347][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
<6>[  150.584418][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
<6>[  150.617760][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
<6>[  150.624253][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
<6>[  150.657906][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
<6>[  150.657982][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
<6>[  150.689571][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
<6>[  150.696109][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected

Chihhao

