Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C0845D9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhKYMND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347267AbhKYMLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:11:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FA1660F50;
        Thu, 25 Nov 2021 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637842069;
        bh=xnjlFXbDw8L2/xkPQz7vQ6uk2frhp1Qq7auUsQgNThk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TtZ7ojJ91XDx4jjygaqVq95xEpGW5jB1pOx1qlAyZTE2iKc9E3a1Apj+QYFX5QoLD
         7Ef/lKnopUCgI8gtQFvjHgyQLUtqKxbZPhVGgF+fNhTWgl/6+wXcxc8Jx1TFHTN8bm
         QGZz4/zrWpjB7/xi1avn2o93exvJHkPd1l8s9OvrQOdzqejPO+FcGtWRbQCp4eVexI
         TecXywTb0NLYVFzGMoKkljBQZQBLG1gs1CosCYrKwevjxTjBtBomy9PVFArLR90Ezq
         wPSSJ8NL6ynzbGs6XuoYOYd/BlvKouS519es1iGVz0iCpPMIk1DkGiES53kJBVl/Et
         SDpV7CtBuarKQ==
Subject: Re: [PATCH 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
To:     Nishanth Menon <nm@ti.com>
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211123103908.14220-1-rogerq@kernel.org>
 <20211123141024.hv3eruvegkahjeou@nuclear>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <21f32f6f-387d-34ec-4d00-9a223362fa09@kernel.org>
Date:   Thu, 25 Nov 2021 14:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123141024.hv3eruvegkahjeou@nuclear>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/11/2021 16:10, Nishanth Menon wrote:
> On 12:39-20211123, Roger Quadros wrote:
>> Hi Nishanth,
>>
>> This series adds GPMC and ELM controller nodes.
>>
>> cheers,
>> -roger
>>
>> Roger Quadros (2):
>>   arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
>>   arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node
>>
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 28 ++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> -- 
>> 2.17.1
>>
> 
> Don't we need to disable the nodes in the board dts files, since these
> are only on optional daughter cards for evm?
> 

Yes. Will fix it up in v2.

cheers,
-roger
