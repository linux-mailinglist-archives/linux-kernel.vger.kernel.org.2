Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433CC436395
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJUN6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:58:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFB7C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:56:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 7F2AB1F42230
Message-ID: <3e0750da-bbd1-b8c6-1270-ef8fcd17e02a@collabora.com>
Date:   Thu, 21 Oct 2021 10:56:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] regmap: spi: Set regmap max raw r/w from
 max_transfer_size
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
References: <20211021132721.13669-1-andrealmeid@collabora.com>
 <YXFxFc1C7QnCQZx9@sirena.org.uk>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <YXFxFc1C7QnCQZx9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 10:54 de 21/10/21, Mark Brown escreveu:
> On Thu, Oct 21, 2021 at 10:27:21AM -0300, André Almeida wrote:
> 
>> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>> [André: fix build warning]
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> 
> It wasn't just a warning, as I told Lucas it was a build error given
> that allmodconfig now has -Werror.
> 

Ok, I didn't know that -Werror was around. Should I resend the patch
with [André: fix build error]?
