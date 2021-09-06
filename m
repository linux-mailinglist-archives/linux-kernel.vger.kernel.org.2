Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A6401E24
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbhIFQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243804AbhIFQTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:19:02 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E486EC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:17:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9AC66DBF84;
        Mon,  6 Sep 2021 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1630945074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=GicACZtYZZ5mQZ04xB3/h4BclRBZg2hz9eM8DndurI0=;
        b=FlDp7/FQ6lm87sDvO+gXkGSq3J74j2cE4+Z4XMkk7CuWBv6P6gCMmrKDWI5mMt4cUUfDtp
        B/5kXYjnAhXZ0OuZhCNntOt/AS74KNCeCDNkpfZJV1E6Li0w0Ac5exuptTeLe4HF8tZvCp
        PpAfkC2wcQOPxfkACJbxOaMrxvHq0VhNniINLUkrOZVyvhFKnT9iGesoANDZRzJ1UPKHNt
        1s8RWnZ2QhMh8p1Y9GR4CghuHdPJXVn7RweHzsgqJ/VI7lGpYnOzvoseszxkp+eDbDigV2
        +ZU4SeqQoJQHc5A1YsqWgcX7Xjddaj1OuXDa8mzUYXmCVSKMKfZpVXo/iq9CwQ==
Subject: Re: [PATCH v3 4/4] arm64: dts: meson-axg: add support for JetHub D1
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210904142745.183875-1-adeep@lexina.in>
 <20210904142745.183875-5-adeep@lexina.in>
 <77699dc0-88d5-3462-15fe-eb376c862d30@baylibre.com>
From:   Vyacheslav <adeep@lexina.in>
Message-ID: <3f58923c-b765-7359-a225-964a9f0a4609@lexina.in>
Date:   Mon, 6 Sep 2021 19:17:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <77699dc0-88d5-3462-15fe-eb376c862d30@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: ru
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.09.2021 15:26, Neil Armstrong пишет:
> On 04/09/2021 16:27, Vyacheslav Bocharov wrote:
>> JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation
>> controller with the following features:
>>
>> +
>> +&spicc1 {
>> +	status = "okay";
>> +};
> Why enabling it without pinctrl properties ?

spiccwas planned for use during the development of the device, but in 
fact it is not currently used. Pins exist on expand pad.

Its better to add pinctrl as below or leave spicc1 disabled?

diff --git 
a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts 
b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
index bc10f3357c09..ecffc90d9884 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
@@ -313,6 +313,8 @@ &usb {

  &spicc1 {
         status = "okay";
+       pinctrl-0 = <&spi1_x_pins>, <&spi1_ss0_x_pins>;
+       pinctrl-names = "default";
  };

  &gpio {


--

Vyacheslav

