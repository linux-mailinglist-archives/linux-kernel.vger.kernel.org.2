Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295D9442DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhKBMb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:31:29 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:39941 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBMb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:31:27 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DD78122246;
        Tue,  2 Nov 2021 13:28:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1635856131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cOlB3SqbrvwOQNlyt+NUWTHe0zxF/8/HFOvQZzaohXM=;
        b=IIaYn2RHSUAHEhe5xnVfhKUDDOsPZ75Idj8t3/tcfjf5uFlySxh6TAWBWv/2tC5WctUwLZ
        E5CaB8w6pyA6bK9ErtpdiKTNxFG/X/S+DNcLQMGsYIi/ToE1untiAIxIddqxKXzrSMazC5
        Tv/ekY92KLkfO1zEFcZJ3ZK9TLnRTjs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Nov 2021 13:28:51 +0100
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Select MFD_CORE to fix build error
In-Reply-To: <YYEeS8gz8TBW63X8@google.com>
References: <20211102100420.112215-1-robert.marko@sartura.hr>
 <YYEeS8gz8TBW63X8@google.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <8b2b9e6f61107b79f93dd191c3fc2918@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-11-02 12:17, schrieb Lee Jones:
> On Tue, 02 Nov 2021, Robert Marko wrote:
> 
>> MFD_SIMPLE_MFD_I2C should select the MFD_CORE to a prevent build 
>> error:
>> 
>> aarch64-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function 
>> `simple_mfd_i2c_probe':
>> drivers/mfd/simple-mfd-i2c.c:55: undefined reference to 
>> `devm_mfd_add_devices'
> 
> What is your use-case?
> 
> How are you enabling this symbol?

Mh? drivers/mfd/simple-mfd-i2c.c is using devm_mfd_add_devices which
is provided by drivers/mfd/core.c. So select MFD_CORE is clearly
missing here, no? I mean most of the MFD drivers do a "select MFD_CORE".

-michael
