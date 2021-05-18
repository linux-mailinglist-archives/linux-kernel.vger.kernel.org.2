Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6747387DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350897AbhERQrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346670AbhERQrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:47:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF84C601FE;
        Tue, 18 May 2021 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621356358;
        bh=bERuiRZe9ZSLOiFNWknCvon0v6tNuzGcD0MRTu/YvXs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gicpzUe46UrSwOfI1A2OHw+RhCE/by0x8+Pq7lhV0Wa7YlwvyGTYtzH1BBhsKObPS
         rWU18sgEW815ByPXMChdjReFS/qKWi1SQTnQHpjtyQFyO+2VeAH7f0kHvwcRMNb/0P
         XDN3Db3B1b8vu5ejsuiOQ5XiZbSIiqtgm7ekNU832oo1gQrTFzAnA/XnA1Gg4QBAbn
         HXz6pjy2BkmuSUWhTseDWM+Nb0CSJod7UBYVos6e/LCpleOg3OseTuspie4Gv7LY1f
         A3s566VwEujzLEnTEttCv6IgyLfPKPCBiA1L5bmPy5jWb3uI3PNFRMDnfo7Vo9Hyy+
         C1Qwu+xCn4sqQ==
Subject: Re: [PATCH v2 0/4] Atomic addfd send and reply
To:     Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>
Cc:     =?UTF-8?Q?Mauricio_V=c3=a1squez_Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210517193908.3113-1-sargun@sargun.me>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <ee341dde-649f-2803-c93f-2acc68b2e4f6@kernel.org>
Date:   Tue, 18 May 2021 09:45:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517193908.3113-1-sargun@sargun.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 12:39 PM, Sargun Dhillon wrote:
> This is somewhat of a respin of "Handle seccomp notification preemption"
> but without the controversial parts.

Looks like a good solution to me, at least for this specific problem.
