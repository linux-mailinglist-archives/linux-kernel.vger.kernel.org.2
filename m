Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E0D443DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhKCHja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhKCHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:39:29 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CC3C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 00:36:53 -0700 (PDT)
Received: from [IPv6:::1] (unknown [IPv6:2a02:810c:c240:2017:dcb:590b:cf44:decf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DA377223ED;
        Wed,  3 Nov 2021 08:36:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1635925008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQ51OSKQaHvREsm8LH+OBDuLYQSwZuSPMGPty/9xfnA=;
        b=CZRcCqrLKBnPt68/X8snzMr+mXYAT6zz8gxXMRiI6TeBpQFKwLeMWWHusw9L8Tkj/rXUQH
        787PKt/P7Bj8g7WHwappA7RmqFDWqlmlWN39TvvAZeU+1XOUWoHmLaSNaesDTg0l6Ftw0I
        lrNeRS5EE7sBz//9w2lb0lio8/Itz9g=
Date:   Wed, 03 Nov 2021 08:36:42 +0100
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Robert Marko <robert.marko@sartura.hr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Select MFD_CORE to fix build error
User-Agent: K-9 Mail for Android
In-Reply-To: <YYI7DFjoCgYMdLl5@google.com>
References: <20211102100420.112215-1-robert.marko@sartura.hr> <YYEeS8gz8TBW63X8@google.com> <8b2b9e6f61107b79f93dd191c3fc2918@walle.cc> <YYI7DFjoCgYMdLl5@google.com>
Message-ID: <1FD0767C-3BF3-46D3-8C7D-BA31F9D7AE0D@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 3=2E November 2021 08:32:28 MEZ schrieb Lee Jones <lee=2Ejones@linaro=2E=
org>:
>On Tue, 02 Nov 2021, Michael Walle wrote:
>
>> Am 2021-11-02 12:17, schrieb Lee Jones:
>> > On Tue, 02 Nov 2021, Robert Marko wrote:
>> >=20
>> > > MFD_SIMPLE_MFD_I2C should select the MFD_CORE to a prevent build
>> > > error:
>> > >=20
>> > > aarch64-linux-ld: drivers/mfd/simple-mfd-i2c=2Eo: in function
>> > > `simple_mfd_i2c_probe':
>> > > drivers/mfd/simple-mfd-i2c=2Ec:55: undefined reference to
>> > > `devm_mfd_add_devices'
>> >=20
>> > What is your use-case?
>> >=20
>> > How are you enabling this symbol?
>>=20
>> Mh? drivers/mfd/simple-mfd-i2c=2Ec is using devm_mfd_add_devices which
>> is provided by drivers/mfd/core=2Ec=2E So select MFD_CORE is clearly
>> missing here, no? I mean most of the MFD drivers do a "select MFD_CORE"=
=2E
>
>I'm not debating that=2E  The patch is fine=2E
>
>I am however, interested in how MFD_CORE is enabled for MFD_SL28CPLD=2E

Because I'm mostly using the arch defconfig (arm64) it
must have missed it because it was probably already=20
enabled by another mfd driver=2E=20

-michael


