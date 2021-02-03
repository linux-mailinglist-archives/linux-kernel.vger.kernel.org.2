Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1F30E630
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhBCWmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:42:24 -0500
Received: from saphodev.broadcom.com ([192.19.232.172]:50670 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232246AbhBCWmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:42:19 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id A908B80D7;
        Wed,  3 Feb 2021 14:41:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A908B80D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1612392088;
        bh=lYj4zON0WMJ93BuQ7DQJTGg6DuwB/NhUT+ze5CcVSUU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L4M16fovf+SZaaaUzl9DU36AJDU7VUDN2tCLdacUIUaxBMmdNSlN+inMuzFYNS1b6
         QX8gnA1k79BcDTkgxQRyUSXS/lp61KlIFL0DFjalDKOtH1zSV8JBJGywW6Lddi/ytT
         JcXLxkET4FoHuopSyjjTFf6t/D7aMj3A1/qZuT04=
Subject: Re: [PATCH] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20210203210451.9002-1-scott.branden@broadcom.com>
 <YBsg+FrU47+S7HFl@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <5a199a7e-cc93-2a6b-e415-459d670f9fc2@broadcom.com>
Date:   Wed, 3 Feb 2021 14:41:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBsg+FrU47+S7HFl@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-02-03 2:17 p.m., Greg Kroah-Hartman wrote:
> On Wed, Feb 03, 2021 at 01:04:51PM -0800, Scott Branden wrote:
>> Correct compile issue if CONFIG_TTY is not set by
>> only adding ttyVK devices if CONFIG_BCM_VK_TTY is set.
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>
>> ---
>> Changes since v3:
> Is this "v4"?  Your subject line doesn't say so :(
Yes, a mistake.  Sent same patch with PATCH v4 on subject line now.
>

