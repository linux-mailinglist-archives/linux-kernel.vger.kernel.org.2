Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6454440001D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 15:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhICNEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 09:04:21 -0400
Received: from mx.msync.work ([95.217.65.204]:42642 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhICNEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 09:04:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76496D63A0;
        Fri,  3 Sep 2021 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1630674189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:
         disposition-notification-to; bh=jjdwfMRF6YgtWfcByL2SGSEFNbz6ru6bgtzK2GxYCIg=;
        b=kyc/gQo6fgKrgoF8Q18pwA8Xboh7m1YmRB/izNYkuZg9tyd1m8v4CLvvGlSUgIqjL+wpTn
        kCcg7RNZR88JrNjDy8+CTQox9SQJXkpk+0R3/eAinIlimnn5PzU+WUfoTb0mWmTV67hzc5
        ffLj/Al9/soM8JgArWdtVY1crJFTNat0+irJ+LitRMwjV920Hf6uo8+YCxnUM1zZcKdzVX
        biO3YmeY+hLwZEJMWUIvUNjS6wpAaqIErVQZJSUVGo9P0MRFbIaaW1V9GF3wKq0YUiiyH2
        55MLEbn1hmf2b4zRLb3Xcn10dcAC0RrC0eyiFRChytf50Mbj7PAE7bWhqjyCjg==
Subject: Re: [PATCH v2 2/3] arm64: dts: meson-gxl: add support for JetHub H1
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210903060035.844758-1-adeep@lexina.in>
 <20210903060035.844758-3-adeep@lexina.in>
 <1jfsulua2e.fsf@starbuckisacylon.baylibre.com>
From:   Vyacheslav Bocharov <adeep@lexina.in>
Message-ID: <23e82fb2-5e28-8c5d-4655-b337af0cf5f0@lexina.in>
Date:   Fri, 3 Sep 2021 16:03:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1jfsulua2e.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.09.2021 15:10, Jerome Brunet пишет:
> +&efuse {
> +	sn: sn@14 {
> +		reg = <0x14 0x10>;
> +	};
> already defined in meson-gx.dtsi
>
> also, what about a new line between the nodes ?
>> +	serial: serial@32 {
>> +		reg = <0x32 0x20>;
>> +	};
> Isn't serial and sn the same thing ?
Yes, my fault. Thanks.
