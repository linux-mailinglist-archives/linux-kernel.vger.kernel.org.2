Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0883F3EC46F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbhHNSXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 14:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhHNSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 14:23:47 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F6C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 11:23:18 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id k24so8353198vsg.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=Tf5xreh+EXaDOdBdIiJb4IE+S8DtM/q8kJSMh7+cvIA=;
        b=FpHmPp34oY1RVF+T6bDjnCvN2W25HJHkLtU8oE8C6tvgd4YWcvyK9J02+6qdbJ7mYQ
         wqx3blRaqxdJpWgZT0nHYWyTXMeqkv+snO15/SM5oEL60VUK1i1bEW8hGN/vinuD34p5
         wUjmCaDVrraOwvMQrv8WKQbkTRiasZKH2+7sf3ZCk977+EbjGxdNbI0Lj2/rZpFLsgzV
         VlznzGnT1KkhZGsESRk1fuUQd7+R1458EhmO3cZJHYZEJX/xmj9lpyzEDaPAl38+5KUU
         JqZT3H8DLkUvGmXGRhWydynPPAJVJbn7/WZ43ThJhGHaQyfMQS7P5Gr38QRxqvi0NQbT
         AOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=Tf5xreh+EXaDOdBdIiJb4IE+S8DtM/q8kJSMh7+cvIA=;
        b=rUR7R5+Aklqz3ZY3XEodfke3RKOAzb2uqI/PveT34kbr7Rqetkoke4XFyqwqR2kR13
         ryP/ISnKoj/VQU07tLyohdBjAdnQBzzJcFsTitqszyRA7eeZN+xLeovPirqxaIZfa8dQ
         5yY5XtM5djXKT+I2i/ebEZIAXIGhuh77KbjYeJ4zS9L3u7q+Epw8zUFN8n7eL3re3Aqn
         PTS8izGTO2qZ0BhPqrGwMkF/BzCsXlho+6U6jYjkfqmyaK0SxXHqgeYWR1EL4Oiv233k
         GModULQObZd1kqO0gaw6n6Hrv7EbJLMZ8WE+N5ivajE5DOVhOGyNCFE3KKp9cRCbfQ+c
         R37w==
X-Gm-Message-State: AOAM531jVJQ5vB1njRJuwwT4RXRq0lq+wDAObVr+1drylyDJ2BEkt2oL
        rUYoHHBzWiyz8Sf0fSyKiFcAv3MTPYH9Yurzp7c=
X-Google-Smtp-Source: ABdhPJwpknbiR9YPdoi+DMQqNTCrmr0yWSyj8P9gAdbGkqyGXNinyam/hP+JznnCCez5Jlpm917gVRIG74TbzssYfSc=
X-Received: by 2002:a67:7f53:: with SMTP id a80mr4382324vsd.13.1628965397412;
 Sat, 14 Aug 2021 11:23:17 -0700 (PDT)
MIME-Version: 1.0
Reply-To: afzzal.ahmed@aol.com
Sender: hassin.ali2017@gmail.com
Received: by 2002:a9f:2c0e:0:0:0:0:0 with HTTP; Sat, 14 Aug 2021 11:23:17
 -0700 (PDT)
From:   Afzzal Ahmed <afzzalahmed0547@gmail.com>
Date:   Sat, 14 Aug 2021 11:23:17 -0700
X-Google-Sender-Auth: IZX8c7diR84tzx3xnNiTkOpAX5A
Message-ID: <CAJsDfshTBKwD=kG4MYxzRYhSY1uBG0S1WW8oKg0kAKwk8HipSw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=2ER=C3=A9=2EBase_on_your_reply?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assaalamu Alaikkum my dear friend,
        I am Mr Afzzal Ahmed, the chief operating officer with my bank
and I want to inform you that an amount of US$37.3 million will be
moved on your name as the Foreign Business Partner to our late
deceased customer Mr.Berry Bryan Floyd, I need your help to receive
this money as we shall share the money in the ratio of 60:40%. You
will receive this amount through a bank wire transfer.

Please send your full names, direct telephone numbers, and home
address, more details of how to claim the form will be given upon your
reply.
Your quick response will be highly appreciated.
Yours sincerely,

Mr.Afzzal Ahmed
