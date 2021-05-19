Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF038856A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 05:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353084AbhESDiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 23:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353057AbhESDhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 23:37:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF11BC06138B
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 20:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=sKHpQcvq+rUPwAULe7dYE5f70g4zQ2kG4rYG08+ZZAU=; b=UqzzuFYfeR7qGqWg3OIyDon2Cb
        7d2qN4MWvw1SFx/Zvl4yiV3LF50MVRli1Jv6GkqL6VoNmCclw6fO8ih22GTHU5G6zQUqZaJ9cl8XH
        CrX3IGSgP9nsAJQsdCg+LQaspJSmAbJzygYWHG7l6ccY0oJvBzoX5oxaP604zmBw6t6JbPVhGTLj3
        n490I3Q4alYbW4QGBZ5WsDt0BJpUzOJeXSuE5hLoc7/OqjGo8wgm3l+ZwDm7H5on/J+CR+M/LbTSX
        PiyrYLKd3ZqXM3V3pGrj3ZIoCkEBWVPtTd8agYOeOeZuEqt3St5LBS3PRoevS9r311Fkx0C8cXfc1
        T4ushvNw==;
Received: from [2601:1c0:6280:3f0:d7c4:8ab4:31d7:f0ba]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljD0Y-00F5fR-3m; Wed, 19 May 2021 03:36:30 +0000
Subject: Re: Am I the only one seeing LKML is lagging badly? Delivering the
 mail ..wondering
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
References: <YKR+OFOPDBc4LMtH@ArchLinux>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d2c549e1-9be0-befa-19a7-c68088133d9d@infradead.org>
Date:   Tue, 18 May 2021 20:36:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YKR+OFOPDBc4LMtH@ArchLinux>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 7:55 PM, Bhaskar Chowdhury wrote:
>  Hey,
> 
>  The mail delivery is happening in snail space. Or is it just me experiencing
>  it??
> 
>  Almost a day behind in terms of mail delivery!
> 
>  Thanks,
>  Bhaskar

Hi,
I don't see it almost one day behind, but on days when
there are lots of stable patch reviews, I see several hours
delay.

But I understand that gmail has its own special problems.
It delays accepting email if an account is receiving "too much"
mail, so it effectively slows down that account.
E.g. maybe it thinks that the free account is being used for
business activity...

-- 
~Randy

