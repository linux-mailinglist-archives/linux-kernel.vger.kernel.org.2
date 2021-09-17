Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE37440F3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbhIQIJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:09:46 -0400
Received: from mx.msync.work ([95.217.65.204]:33496 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245125AbhIQIJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:09:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED37A1073BD;
        Fri, 17 Sep 2021 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1631866006; h=from:subject:date:message-id:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:
         disposition-notification-to; bh=K8pUvKYmihVFtXVo7mlfRJfCXmaPt+xZW7fToK+rFyQ=;
        b=NkzIUlrcyoaOa6SpQVwrx5j7MONIVEgATiUUOSEdUp5y/Lxuusc5dVnxUPuYeDIDcBBgxs
        YebI7LFHBOQ5b94cH3Y91DWjHpG+39kmu3mY2fBCFhwl5si+2z643RZnm+nKWaL16TfaN1
        D4Gxt8hc8CTLxVDVPvZiw9UZpuoeK8wd9V5fGbS8R45J1W4oZoCmhP8xdxcQoCMj9qMlnO
        6KmBZc2UIt4Qlic7CHfXunJmnqrFl5mNltxOkC0d0cg48j3kAPywgd3a+DhOpMf3mgKTh7
        OFuzfNz2npYHp8O3kHD6/DMUlmnMUaViORjxp3UrsTikQ7/1XyCoPGKTP1MIEQ==
Subject: Re: [PATCH v5 0/4] arm64: meson: add support for JetHub D1/H1
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
References: <20210915085715.1134940-1-adeep@lexina.in>
 <163186366690.1044811.10268335087144036716.b4-ty@baylibre.com>
From:   Vyacheslav <adeep@lexina.in>
Message-ID: <24c06118-5eee-055e-e9c6-bbacd6e2eea5@lexina.in>
Date:   Fri, 17 Sep 2021 11:06:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <163186366690.1044811.10268335087144036716.b4-ty@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.09.2021 10:27, Neil Armstrong wrote:
> Hi,
> 
> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.16/dt64)

Thanks
