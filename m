Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5621422607
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhJEMPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:15:30 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:44724 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhJEMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:15:29 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 195CDaew012089
        for <linux-kernel@vger.kernel.org>; Tue, 5 Oct 2021 15:13:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1633436011; x=1636028011;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AebaI2Opn2KDPkehW8betq17Udp5gRls6N7tILPVKdE=;
        b=KMDZ/rH7xbXqfOwJ8A7rPVPIT9MNC9dNxDabBtR4M1cDWlKWoam//LqvePaiKJXR
        H+TPaiyHMTojAsZL5TWy7S9DNal5iUggaf/ARI2GCBxokPs8tyoseTpJTCYNtPSj
        kzDxzZPJOxVNpsTEPW8A4rLq+LzMDnLKW4zRLtH3Hu01Ftz/v6zKZMqJftZ8xyn6
        anhYehK7NTsoVnYoDrL1/QKE37D8tRQho+3wPRyiOSdMrMV0wM43eX10tTdwzIo2
        gF5bwSSF0o87RWootROYfpqu8yEYYJ2rflIuUAsFIuaEby22QBoQwBbYr/L4+/r6
        0NY5nSXF7NBBr/s8Z9HUxQ==;
X-AuditID: 8b5b014d-ba8f670000005d46-88-615c416b4968
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id A6.62.23878.B614C516; Tue,  5 Oct 2021 15:13:31 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Oct 2021 15:13:30 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr, rppt@kernel.org, geert+renesas@glider.be,
        Stephano Cetola <scetola@linuxfoundation.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>, palmer@dabbelt.com,
        anup.patel@wdc.com, atish.patra@wdc.com
Subject: RISC-V: patched kexec-tools on github for review/testing
Organization: FORTH
Message-ID: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXSHT1dWTfbMSbRoOWtisWzO19ZLZ58mMhm
        sWjFdxaL/9ta2C3mzp7EaLH79Fcmi8u75rBZbPvcwmbx8nIPs0X3ymqLI+u3M1nM/rCExYHH
        483Llywe905MY/WYeFbXY9OqTjaP/XPXsHtsXlLv8XmTnMfO2w+ZPNoPdDN5TDnUzhLAFcVl
        k5Kak1mWWqRvl8CVcbvhMXvBZOaK3ysSGxjvMHUxcnJICJhIPFt6Asjm4hASOMYosWvmM3aI
        hKnE7L2djCA2r4CgxMmZT1i6GDk4mAWsJdr3GICEmQXkJba/ncMMYrMIqEqsnvQYrJVNQFNi
        /qWDLCAzRQQ+M0l0XGgEmyMs4Cix8t9tMJtfQFji092LrBDzXSReP/rEBrFXReLD7wfsILtE
        gezNc5UmMPLNQnLFLIQrZiG5YgEj8ypGgcQyY73M5GK9tPyikgy99KJNjOAYYPTdwXh781u9
        Q4xMHIyHGCU4mJVEeK96RSYK8aYkVlalFuXHF5XmpBYfYpTmYFES5+XVmxAvJJCeWJKanZpa
        kFoEk2Xi4JRqYMoqv2tkW7Rki6SG4Ifk8oVe59arzCx+dLv9ljCLwqJflRwXl/bwTgvUmxs9
        e0XIpIP+Mo57Vy/36F/o/nJiejJLaJWm6b3dkWtTvl6XPBGsq7VEIX+W++P/Hq2WswN3xa/w
        F5sYW295oCZIajPHnb+vjYVsDme8jBKtYuLdnt76npHXckLfgnXSyQp51tHezodazv5QPLaB
        mTXxgJnz6XTevJmbTBpiZv4LEFaq0pNeFuqvGuB/8fFNqcC13Ov/Zhi8LJivmtakmla3r+vF
        feXZR1x3Ld2zpmU750k9LobUPuHv3hf2aV6LPSyasWxHffj9si+zbJ5k8bw5EdgbobzlfI+7
        gr711lWzT4sdUmIpzkg01GIuKk4EALq7jjfwAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I've uploaded my kexec-tools patches for riscv on github for 
testing/review before sending them upstream.
https://github.com/riscv-collab/kexec-tools/tree/riscv

Both kexec and kdump were tested on latest rv64 qemu, using for-next 
branch with this patch applied:
https://patchwork.kernel.org/project/linux-riscv/patch/20211002122026.1451269-1-mick@ics.forth.gr/

Regards,
Nick
