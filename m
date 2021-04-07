Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC92356D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhDGNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:25:14 -0400
Received: from mail.efficios.com ([167.114.26.124]:53052 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbhDGNZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:25:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 95B173255A1;
        Wed,  7 Apr 2021 09:25:02 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uUZeE4Cj45Pe; Wed,  7 Apr 2021 09:25:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 894153255A0;
        Wed,  7 Apr 2021 09:25:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 894153255A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1617801901;
        bh=DXc2Y1rh5gPP9QGS3ROSlNDTD3fE09xVwWFxdvNOyqw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LpgqVl51fvV18lzpn3ldBJ4w45shpnUo3aYPTX4B9XERyD9JuoInD8BqZYmK+S2cg
         K67onG38Kd07fBaLJC8Kpbu/J4cnAnmcDPLpii85U0bbLeofcLywzC1pzEkuEurjP6
         Zzyu9MUMhs29hX3pztg0Pcta8bpi3TLP0PHRU7/uRk+cEyu+Z/QeuEWQocua3hjX5b
         +aWOr3YZIIIYk2tAMp9Ox0Fv3b738rmtZ7HktIQlJGB46k884NL/462W1qR143ZPMK
         ILsxH2YVTgKg0KKd1I7J/r7IAYFGOIWrPhqzUqq8lDkDT5nHSljS7bSgfzWfwBEmy6
         YYZP54/Oy8zJA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N5MCYS6mg6Fs; Wed,  7 Apr 2021 09:25:01 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7D7EE325292;
        Wed,  7 Apr 2021 09:25:01 -0400 (EDT)
Date:   Wed, 7 Apr 2021 09:25:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Mingyi Liu <mingyiliu@gatech.edu>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Message-ID: <723248518.60240.1617801901472.JavaMail.zimbra@efficios.com>
In-Reply-To: <MN2PR07MB80147F72667BBA151586486ED1769@MN2PR07MB8014.namprd07.prod.outlook.com>
References: <MN2PR07MB80147F72667BBA151586486ED1769@MN2PR07MB8014.namprd07.prod.outlook.com>
Subject: Re: about seg fault inside rseq critical section
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: about seg fault inside rseq critical section
Thread-Index: AQHXKzICNtuXzcd7b0S3OpsM3Zas5DaS7ozS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(re-sent in plain-text for lkml)

----- On Apr 6, 2021, at 6:24 PM, Mingyi Liu mingyiliu@gatech.edu wrote:

> Hi Mathieu,

> I notice that the program will be terminated with segmentation fault when it is
> even seg faulted inside the rseq critical section. In Linux kernel rseq.c, I
> haven't found comment or code regarding this. Could you share any references on
> why it doesn't execute user defined abort handler but uses the OS handler
> instead?

> Thanks in advance!

Hi Mingyi, 

Please let me add the other rseq maintainers and LKML in CC. I'm a bit stretched on time 
here, so maybe they will have time to answer before I do. 

Meanwhile, if you could provide details about your architecture, kernel .config, and a 
small reproducer program, it would help bootstrapping the discussion. 

Thanks, 

Mathieu 

> Best,

> Mingyi

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
