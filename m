Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3E042C6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhJMQqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhJMQqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:46:18 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CBFC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:44:15 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id ba39so1106399vkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+tWksa0EGo/fAypXGuJ0wq/G0QTysSK2EhBlYveMXk=;
        b=mfY554ASr4C3nbOEBJvhs7R8hS8eZqgND52G7Gp2gioBhxao7Uhj22OW4kb4znjCxn
         nGPRKpFhYu6OumK9pWf3Q7JsdFTSDJ8mQeNCK2/qDbs6CaIRRc2fHwQg+lLWAj/AqQb0
         JzAPaW4YXf0urAqRTFvhpUC6vxnoGBf0D3KCpGyOd6yybjiBIy3GGz+5iysGKl6akr43
         5xhH++qkoQn/fK9uU3IQDG6vLgpq0CvxC6LipET+CFrwrU/FF8NbMInRYMtj94JqU6pJ
         8ox03ZFjqfVylA+ejsMAclvxKFyGYcUNuZR1OW8iu8Gvwage3WTLI6gvGmJ/i5fNWb1y
         TV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+tWksa0EGo/fAypXGuJ0wq/G0QTysSK2EhBlYveMXk=;
        b=be1GQ4OdEnrhffdZfKOccj4Iadcqlwt2L83ZCqoQpQs2fML6I4VvFUbhwW2+NI+mnY
         iiZNCCKjX9/FVP+LBh279yXfvqCfnH2LrtCOLcmw0DndDXGDwf2N7pIoiy74RZ6AwrKg
         bi6tuZJoiVjWiQq1xMEYvBg/Qxw728W+ojcOHdwWg6GCrE7AMwmAJRPta4dgOv24ZJSL
         0ZHcONFbO3bqsKfJaoOjlq6pzswd7XEh9Mw/dpZSIwziMflt9DBf8Tjaw3N/CuohbxDc
         4Et9pNri78Kg8yNo5NqQu9bwaLT06sJFH/Cp8rEeJJFnoKok84tC/FEEPsA0T4Tep1zM
         pb2A==
X-Gm-Message-State: AOAM532p6MXUBr2sXQgAgUBaakmO39zG7CfviTPeBt1oapu0dZ8baHsl
        B+hwIypJcXSM4sEQaTb7OMfbsjczlpD57xlKkaY=
X-Google-Smtp-Source: ABdhPJz2lBCHczxLwlKqTbVojKr/w7166OPYEtb8UDB2S6LFU/XdeKPsm1lOLOy5HsHsMJ90UjGRqsbJ8+UvCgLSzII=
X-Received: by 2002:a1f:6047:: with SMTP id u68mr5161148vkb.15.1634143454123;
 Wed, 13 Oct 2021 09:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211012183310.1016678-1-jim.cromie@gmail.com> <YWbdnsUjHA4Mmss3@kroah.com>
In-Reply-To: <YWbdnsUjHA4Mmss3@kroah.com>
From:   jim.cromie@gmail.com
Date:   Wed, 13 Oct 2021 10:43:48 -0600
Message-ID: <CAJfuBxz4FQM=MLj5MUCv22q87hyPkaiE43RZ+CBa6Br=3ROmhw@mail.gmail.com>
Subject: Re: [PATCH 0/5] dynamic debug for -next
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 7:22 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 12, 2021 at 12:33:05PM -0600, Jim Cromie wrote:
> > hi Greg, Jason,
> >
> > Please consider these "more selective verbose info" patches for your
> > -next tree:
> >


>
> I took the first patch here, I wanted to take patches 4 and 5 as well,
> but they did not apply because I didn't want to take 2 and 3 right now.
>
> thanks,
>
> greg k-h

ok thanks, I'll re-order 4,5 w/o 2,3 and keep the latter locally
