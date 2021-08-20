Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9F3F2E65
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbhHTOt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:49:56 -0400
Received: from foss.arm.com ([217.140.110.172]:33536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240879AbhHTOtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:49:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DA3511FB;
        Fri, 20 Aug 2021 07:49:17 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A67A3F70D;
        Fri, 20 Aug 2021 07:49:16 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: rockchip: remove cap-mmc-highspeed property
 from mk808 &mmc0 node
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, paweljarosz3691@gmail.com
References: <20210820131920.1831-1-jbx6244@gmail.com>
 <bf6cba99-da3b-a6fe-4e4b-f4ea6e3c6e63@arm.com>
 <c52b4cf0-d018-f6b4-8728-41551b8bf62b@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d3b574f5-b49e-60be-1559-b98e0832bd62@arm.com>
Date:   Fri, 20 Aug 2021 15:49:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c52b4cf0-d018-f6b4-8728-41551b8bf62b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-20 15:41, Johan Jonker wrote:
> 
> 
> On 8/20/21 4:17 PM, Robin Murphy wrote:
>> On 2021-08-20 14:19, Johan Jonker wrote:
>>> On the MK808 only a microSD slot is connected with the SDMMC Host
>>> Controller,
>>> so remove the cap-mmc-highspeed property from the &mmc0 node.
>>
>> Why, does it do any harm?
> 
> Harm not. Example rk3066 u-boot:
> 
>>>>> sd_select_mode_and_width
> sd card: widths [4, 1, ] modes [MMC legacy, SD High Speed (50MHz), UHS
> SDR12 (25MHz), UHS SDR25 (50MHz), ]
> host: widths [4, 1, ] modes [MMC legacy, MMC High Speed (26MHz), SD
> High Speed (50MHz), MMC High Speed (52MHz), ]
> trying mode SD High Speed (50MHz) width 4 (at 50 MHz)
> 
> I would say only advertise host capabilities that are under normal
> circumstances occur. How realistic is it to use a TF/Micro SD TO SD Card
> Extension Cable Adapter (giggle) for a deprecated mmc card?

Well, if you want a far more realistic example:

https://www.hardkernel.com/shop/emmc-module-reader-board-for-os-upgrade/

Who are we to dictate what "normal circumstances" are, and what do we 
gain by removing support for modes that could work fine and at least be 
useful to someone on occasion?

Robin.
