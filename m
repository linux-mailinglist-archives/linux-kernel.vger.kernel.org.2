Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4473F3FFA56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244109AbhICGZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:25:23 -0400
Received: from smtp3.hiworks.co.kr ([121.254.168.205]:18477 "EHLO
        smtp3.hiworks.co.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhICGZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:25:20 -0400
Received: (qmail 120186 invoked from network); 3 Sep 2021 15:17:39 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.161)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        3 Sep 2021 15:17:39 +0900
Received: (qmail 18377 invoked from network); 3 Sep 2021 15:17:39 +0900
Received: from unknown (HELO DESKTOP3HTLQGF) (tykwon@m2i.co.kr@58.75.176.98)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        3 Sep 2021 15:17:39 +0900
X-Authinfo: HIWORKS SMTP authenticated <tykwon@m2i.co.kr|58.75.176.98|tykwon@m2i.co.kr|210903151739_588918371>
From:   =?UTF-8?B?6raM7YOc7JiB?= <tykwon@m2i.co.kr>
To:     "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc:     "'linux-mmc'" <linux-mmc@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <20210624061418.30361-1-tykwon@m2i.co.kr> <CAPDyKFrh9azyXNwFHxoe1svDQKRWbr5FpWz3V_JOD+Zv0cHcug@mail.gmail.com> 
In-Reply-To: 
Subject: RE: [PATCH] mmc: core: Added support for LED trigger only when SD  card is connected
Date:   Fri, 3 Sep 2021 15:17:40 +0900
Message-ID: <111301d7a08b$66710460$33530d20$@m2i.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQM/ouEl57R0GPXs7J4RkiPdEOUrjgFbgzw3qEjedVCAbhYg0A==
Content-Language: ko
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm guessing it's because of the NULL in the mmc_sd_remove() function in
> drivers/mmc/core/sd.c , but I'm not sure.
> I think it was clumsy because I was a newbie unfamiliar with mmc
> drivers. :) I'll take a closer look.

This was a hardware issue.
The CD pins on my hardware kept vibrating. :)

