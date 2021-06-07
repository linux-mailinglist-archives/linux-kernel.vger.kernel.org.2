Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D539DD53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFGNL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:11:56 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhFGNLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:11:54 -0400
Received: from [192.168.1.155] ([77.9.164.246]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MkYg4-1l4Ylt2c0c-00m2Zz; Mon, 07 Jun 2021 15:09:19 +0200
Subject: Re: [PATCH v7 3/5] nvmem: eeprom: add documentation for FRAM
To:     Jiri Prchal <jiri.prchal@aksignal.cz>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
 <20210607122640.143582-4-jiri.prchal@aksignal.cz>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <900a7dc8-96df-adf7-56b2-e412ea3764fe@metux.net>
Date:   Mon, 7 Jun 2021 15:09:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210607122640.143582-4-jiri.prchal@aksignal.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d+RuLzp6otw+pJTVerN/pjSIZDeCVf5E2t812aXXtl8XTJgVEPG
 8QyuWr2dQllENLW04nPRTvjEH9EO7MQQLDvzTWXMZHXocwPKHUfuDGGZRA1EIUt9LDDqRs+
 s+ei5QlcMqk71aujzYqboFG9/a7aoidJWeCiZRjZEyPg6gYAx7HvquB4q5/20bGDXL7mG9G
 VooyGCR9HjW+ZW8bA68fQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5f5wmOhpNZI=:iIMuzC1HirrgVMZG66Vt9E
 nVhM8bHhKeTdaE4io7pdXYrf6jhczTl4Y71BPKZCIf5S4waqRWMHEHgkyqtTUKx7uJA1e8VCd
 F4qQXgBdvgVIwz4DfYUlsjOfit7r4qG0olHv32L8hIr5kU776xABew357/DbaiN8PmUtS3jQ8
 3UcsGvscXaZ+wkDmJXE0rMITR1eHDbejX2Y82SnFSbP11by3NgKrkuw/UoyodNpPtFWVSljVm
 LG+cKx3oRCJcr41Ogs/A7nyhr/rUSUrhAzFS9ypuJ0u1K2mX12KlhOQQYgakCJlOUJPaGYfg3
 r9SdNtRhCYy+NyvL+oQSg4y0GZi9YnBWIEtvmDDdPppXlQ3Mvv9iYm0CmdB6G1ChfNzwL0tUg
 j3KYBqsIOcRJ6OmLfbQo2pEtbofUaW4fgCsQ+hRXl9Q7B/nXmP+sCImDUuMu96WRXjgxk8RqT
 F7X8pKqq4sjED3azN8niG3vDudmTi5/EfVO6f0CO9lrJLz6VWQMK/JhtH0v4C9JjQsa6vaJJu
 2A+gBpqZSZtXC5RvdPcN5Y=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.21 14:26, Jiri Prchal wrote:
> Added dt binding documentation.

I believe subject should be something like that:

	"dt-bindings: nvmem: at25: add for fram support"

--mtx
-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
