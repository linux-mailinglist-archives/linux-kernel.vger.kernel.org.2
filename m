Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77F540EA59
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbhIPS5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243594AbhIPS5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:57:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69333C05BD41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:11:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g1so22014231lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=7cbYprtViCbGFSCYpKEkbMaY3bf1Nu/Wu2L8+nrDJDY=;
        b=AhBYANvJrI/J+GCgrspN8CLOCQasI4BKUgGBE4RZm9CF68XAxTS9KOsCbWEYZu5p70
         hhRRVtBLKgBU0u3mmz1MpzlNMzbPy46WCEhUBD02A5pbgMaiUD1UHqN2hrAVRY5vLPHN
         HqO05Orvk6VP+dYapVaEf1AlETJSgs7ug4R3BIBvJ2bAWwWJh/2LimOrU12tz5zFMLqI
         IsbOXdvnmm5R5S+EhoAhqLqvU6k5h55jGyKgk15HHmDLacSd1Knw1Q96+ajMSNbFo0wj
         Q32Ib+7TeHYVy6VmwUY0UIdvuWurWQqqJ7I48VXwDPQo9eO1UShSBrghRaBcHv8hGbGl
         dyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=7cbYprtViCbGFSCYpKEkbMaY3bf1Nu/Wu2L8+nrDJDY=;
        b=mkNC69jdcE4vY8zN8cNb26udhSpfXsPLA/qxOfHOYYAGFGFj9ml3WNHEzKksOlQYJ+
         adhuVtGAeYOcJ3UY9enuMoxwFtpfIA00uOsZ1BlAhssTjwTsPzjGuEWDJ3M+eclwh0Ek
         Hq2sKHqGro2yx3HVOXCFjBzF6zEbpH+dlgrVoIdnjncp1m8buclJT3gc41E9XFv8B/XG
         09olh1IaRh3Gcs1LtN4Z2l9krrwg9zJFUYlGbybsj7ipEQcZTNGuWhmE3La34nFApf8K
         vFmnxh3LgXrkKc/I1OELUf8BJ7l4kW7aCV7QxkWNCNBScW7xDXOKlft1SZVOQlLQZZGD
         +5Xw==
X-Gm-Message-State: AOAM5307+JvT6hINL3XXqUGl3Hos7vtdzcMyz9Zz1cUILdU8ZUgLrhw9
        pv+B2UJroM9TnO8eSMFq6j2ezRJsd+KGsDYyA5k=
X-Google-Smtp-Source: ABdhPJy+7RmXJlMx84L981i3rtUdT2Nt6OJSWnN3F6eN34phXm7eseAKOFdqEGXb5QRguUGyKd/f3dWCdHrQP9Gfhy8=
X-Received: by 2002:ac2:4822:: with SMTP id 2mr5215791lft.325.1631815861646;
 Thu, 16 Sep 2021 11:11:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9653:0:0:0:0:0 with HTTP; Thu, 16 Sep 2021 11:11:00
 -0700 (PDT)
Reply-To: db.bankdirecttg@gmail.com
In-Reply-To: <CADMzAGxij7DmppSN9wMUkzdvUhvJxpAKzQ6YGtmNZ=to6zddBQ@mail.gmail.com>
References: <CADMzAGxij7DmppSN9wMUkzdvUhvJxpAKzQ6YGtmNZ=to6zddBQ@mail.gmail.com>
From:   "db.bankdirecttg@gmail.com" <jpaulesq753@gmail.com>
Date:   Thu, 16 Sep 2021 18:11:00 +0000
Message-ID: <CADMzAGxDkrM5thZKO2BM_smvjw8cS1_zxF7G+Q0pqdM9xNaUnw@mail.gmail.com>
Subject: wu
To:     db.bankdirecttg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Our office contact, 2554 Road Of Kpalime Face Pharmacy Bet, Lome, Gulf.

This is WU bank director bring notice for you that  International
monetary fund (IMF) who compensation you sum of $850,000.00 because
they found your email address in the list of scam victim . Do you
willing to get this fund or not?

We look forward to hear from you urgently.

Yours faithfully
Tony  Albert
BANK DIRECTOR
Whatsapp, +22870248258
