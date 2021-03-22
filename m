Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB623436D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 03:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCVCyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 22:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCVCxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 22:53:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76661C061574;
        Sun, 21 Mar 2021 19:53:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w18so17548291edc.0;
        Sun, 21 Mar 2021 19:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZC8K3XIqR0qeKqh/0Uh8gjLXCIPAa36nU6xewLZaFSQ=;
        b=G1jqedd35PYvVEwlQId42fXLpbNAPyWhXkJFsAxf21pEqhKPaqavPeX+Zet1JRdOB/
         rgY4HcMcY55jB3zRN8TdiWpTD31EQ1zvb5oC6RqceDLvRkd5KjZZC8bqLM78Me2CmR/1
         o18m6KOLNoKJjjF/W+GffqcoqWkPZMSaK0lf8BhGmv09C813le7uSZ64bxu9FB8U+I1G
         PRB+1XZCiZBF0s79fDGTpwC2Zr7cv6vmfwLQGQIAq7wZYwRHRcmP3DizaJ00xfrVyLyG
         DCYg1klkceWOR6ytroKbOBEKwo0pGcnYqXsPIssrZIy39ZlgmhNn6ZsArPJx/si3CePo
         jDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZC8K3XIqR0qeKqh/0Uh8gjLXCIPAa36nU6xewLZaFSQ=;
        b=MqSZAtcUR47+wvrvPk75LbiUMX6itRNLMnVlWhpE4QSv15XuY73eJyRiMeBBMNLCt4
         xiGg8J/NwsPTIXHtt4PjAlZWlUk2TNbcaQDNA4cSto74nFBdHf8SU9MMY5FLanYhSbwv
         B6dj9vERrGw34htxWVZcXRaxTepr/k2aQtAm3cVZy5EkVo+n3XwiKtMX+8LtlMSZcEtU
         ZgourIiiPqQFxscMvCe+AS1QeE1QVdkNCHzido/6fnaWbJW18ulIgI5oi/HDT1fNULpv
         rxQ1saq6V5ETIQEnxZbF6UaQ9KWq/lN/xDBl1Ciai74i34jXGFWgfqGMY8myvLxw48WR
         GcXQ==
X-Gm-Message-State: AOAM533Ogjf2ShHoot61CGe56VT0PZmwrMtWFWLlXR8hXe3QTGLbJyuj
        c33ZioS6Wmmhjj6z7uQLsbGmmPI5aQlDr8d3ZPzAmzyepQx0Aw==
X-Google-Smtp-Source: ABdhPJyw9pQg53ScmPhD+PV9bMRTqbsDgaZ8vQYgXApw6mwuEiiODlW5XEK0iyK3RserMgeI9D4xfvynzVQgFILnAGM=
X-Received: by 2002:a05:6402:4407:: with SMTP id y7mr23438720eda.247.1616381618864;
 Sun, 21 Mar 2021 19:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmOe3SaBn9+XzjhZC8QxmZnHQkvB0R=nV4NaRRyMRF6EfcvvA@mail.gmail.com>
 <CANiq72m=kDd97+n1Zxwi5+7M8cwreoq1P_u5YZ25Dcyx40jNdA@mail.gmail.com>
In-Reply-To: <CANiq72m=kDd97+n1Zxwi5+7M8cwreoq1P_u5YZ25Dcyx40jNdA@mail.gmail.com>
From:   Joshua Abraham <j.abraham1776@gmail.com>
Date:   Sun, 21 Mar 2021 21:53:27 -0500
Message-ID: <CAMmOe3TNt2vgX=fp77yvOx7s3+CeDonkd=Unb-y2hau66M-fsg@mail.gmail.com>
Subject: Re: drivers/char/rust_example fails to load
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Miguel,

> Please give a go to the nightly from a month ago, i.e. 2021-02-20.

Cheers, using rustc 1.52.0-nightly (9b471a3f5 2021-02-19) fixed the
issue. Interesting that the newer nightly compiler creates these new
relocations for the code!

-- 
Respectfully,
Josh Abraham
