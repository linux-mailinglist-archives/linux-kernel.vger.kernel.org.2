Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D150404848
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhIIKPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:15:51 -0400
Received: from mx.msync.work ([95.217.65.204]:42616 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhIIKPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:15:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03914E3862;
        Thu,  9 Sep 2021 10:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1631182478; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:
         disposition-notification-to; bh=UtHV6Jt05brS9pYbB9Q5jpcPpg+KZYZgCFNAF9a2mPE=;
        b=f8ONxOhCamFYg6dvg1zyPdFDJmmZRr6C+/E6DxpsIQLZp6yb2zt8Z+/tiDF21pArGTK5JO
        owhllisCy7RkEbUUTpDO+MeK/cj6sUn2GaMf/oISh/iKEsGKgfKWv8dp+JiWupQ1SZ6Ueq
        wWXvwSi27lWpBiK7m82MrvgQDQYwX/rGoGg8TuQ5ZVIJDvbhmjaGOnLXpUMR8+nH3OsGjl
        FgMIK4CpvSLfvsH/6AHbdLI4qAYSkEwGij7LDX6sSsEDOzzqNDt2rzh+4UvXJGwowdkFyU
        V32et9GsPEBlOlvGvz0BVEn9JPvXtEmJtl2lOmr36gYhEDCIFLH1ygzFHOVw6g==
Subject: Re: [PATCH v4 4/4] arm64: dts: meson-axg: add support for JetHub D1
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210907095603.1520109-1-adeep@lexina.in>
 <20210907095603.1520109-5-adeep@lexina.in>
 <9c6b69e0-0c3b-c1b9-d74a-c66b7bc5b5c6@baylibre.com>
From:   Vyacheslav <adeep@lexina.in>
Message-ID: <5f0526f9-38a7-eb51-4e14-e9f931ad135b@lexina.in>
Date:   Thu, 9 Sep 2021 13:14:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9c6b69e0-0c3b-c1b9-d74a-c66b7bc5b5c6@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.09.2021 09:56, Neil Armstrong wrote:
> Hi,
> 
> On 07/09/2021 11:56, Vyacheslav Bocharov wrote:
>> JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Thanks,
> Neil

Thanks.
