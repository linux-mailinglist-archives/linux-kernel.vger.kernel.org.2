Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54239611A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhEaOfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 10:35:41 -0400
Received: from air.basealt.ru ([194.107.17.39]:58850 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232365AbhEaNzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:55:42 -0400
Received: by air.basealt.ru (Postfix, from userid 490)
        id 1B1F458951E; Mon, 31 May 2021 13:54:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on
        sa.local.altlinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
Received: from [10.88.144.159] (obninsk.basealt.ru [217.15.195.17])
        by air.basealt.ru (Postfix) with ESMTPSA id 82531589517;
        Mon, 31 May 2021 13:53:58 +0000 (UTC)
Subject: Re: Problem with i8042 and PS/2 keyboard on HP laptop
To:     Vojtech Pavlik <vojtech@suse.com>
Cc:     linux-kernel@vger.kernel.org
References: <f586401d-73af-097f-812c-f033a922bfc2@altlinux.org>
 <20210528154339.GA9116@suse.com>
From:   Egor Ignatov <egori@altlinux.org>
Message-ID: <ea8f1d77-99d9-8585-1d44-8a20e6af12a0@altlinux.org>
Date:   Mon, 31 May 2021 16:53:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528154339.GA9116@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you so much for such a large and detailed answer, it clarified a
lot about how the driver works.

I tried different combinations of options that you suggested and the
only one after which the keyboard immediately starts working is
'dumbkbd'. So I added a quirk and will send a patch soon.

-- 

Egor

