Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4043E0E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 08:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhHEG0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 02:26:13 -0400
Received: from [103.31.38.59] ([103.31.38.59]:52970 "EHLO gnuweeb.org"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S235809AbhHEG0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:26:12 -0400
Received: from [10.7.7.2] (unknown [68.183.184.174])
        by gnuweeb.org (Postfix) with ESMTPSA id EE8E2C2AC0;
        Thu,  5 Aug 2021 06:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuweeb.org;
        s=default; t=1628144756;
        bh=4RbEhLDQkueWhK1hwmARWHUAZjpzNfcg7cI/uu/Aek0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SsJoZurqglLCtPovD1acJOZOdQTxzQCUWckiZmu6RRgrR01uERlWI8ofvoimlLfW9
         cWMsDoCv4ONPaUw/0tO/WOixXUBXp7ya5wSaDs3svMtRmrHCLk5G5SEDQ8g4NMzbox
         BorRJROmJpc3nFd4AkovuT5nMJpBOD7ajgfpnhElzDTjpIW8CyOBbkdnzsLuibLeVM
         JSvZEGHHlGGP98bpqtzXveyxSMM0b4qyD+brmNy01lQar1rN7BI9ViNMFVUPJQ0s6y
         hNhGPSTMM7JQnFoxln3799BKHXTMiEDPUqVOIgZ6fJvQb0WulqaFXNUJJsre+SEYJu
         RLguw3hEZpUTA==
Subject: Re: WARNING: possible circular locking dependency
 detected(hci_sock_dev_event+0x17d/0x1f0)
To:     Hillf Danton <hdanton@sina.com>
Cc:     Lin Ma <linma@zju.edu.cn>, Marcel Holtmann <marcel@holtmann.org>,
        Ammar Faizi <ammarfaizi2@gmail.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210805020048.2509-1-hdanton@sina.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Message-ID: <c73c45fa-3d46-915f-02be-f9d2ede12bab@gnuweeb.org>
Date:   Thu, 5 Aug 2021 13:25:52 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805020048.2509-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 9:00 AM, Hillf Danton wrote:
> As to that UAF, feel free to let us know once you have a reproducer
for it,
> then fix to it can be prepared.
>
> Hillf

Alright, I will try my best to at least understand the UAF issue first.

Hi Lin, could you help me about the UAF?

BTW Hillf, why can't I find our conversation on lore kernel. It seems
we've messed up the thread. I don't have any idea why this conversation
can't be found on there.

-- 
Ammar

