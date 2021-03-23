Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80E346129
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhCWOPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhCWOPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:15:12 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:15:00 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l13so14953825qtu.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8meLTlZiRn44+DNLKrLTAm0jlzGdfeXlOKDf3nF1S5M=;
        b=n+CyHXpCvNqgjqFQCw1Ureb1Am9mXfUzWPryDTmL9fn8N185+8k0ujfQ90CxHy+7gw
         UuBUGTldeK/8XlUoY9uQctm+OnklBCyJkoRD5xytOFFWWh0e311QC6oG4Hm5YIOK20Fp
         1u8Wa6FaiMd6Y1rqA7D3tAQurFqw+XEnoo9Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8meLTlZiRn44+DNLKrLTAm0jlzGdfeXlOKDf3nF1S5M=;
        b=D+TOwQ0rtm32/Pf2L8fKWA9jaAEmkiHuGVJuYuodJxfZOrKdyVkWz06e4vrH4eOyY9
         4m4s2z4HHnQOCnMEKY8I1lunxxTH6HqNFqrki/mmYfUfS1RxtrA0Q2Hs4xk7JFPhhMRr
         500Dsee7kCEzs9hJZUdyh+WbmBl7gOS6KciJmM8lS4Wi+kZL8cdArX2Xt2x3Yqsttu1k
         Z5AI3/heHQtTVSZU0Dt8spDZS6e0wRWvbfKqhN41XESALpzgm5b9BYJMkzFf7VUfvT5E
         DIvC4i+TZJNtOk/2cLESDmWqC7vLoDxw83JClsvoeRh0Rs/0Q7dlOQNXE9oYXBwKl1vu
         dmbw==
X-Gm-Message-State: AOAM530hrdOqV/UIfs9BLUvXLym1E2J6WBWkMPedOHCD4wL20sH5uDjw
        +21xhDs8yltKtiXGHhm0XOC85qeqqV/rGE13MVdyhg==
X-Google-Smtp-Source: ABdhPJxLLCxlwvhUtL+3J+uDzjutd5tJWRqZy+adGA0su0wQFjLXycNlNjHEqpTnreoLpM52ToOL+31/uFkoXSn7XwI=
X-Received: by 2002:ac8:7f53:: with SMTP id g19mr4492681qtk.249.1616508900014;
 Tue, 23 Mar 2021 07:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210213095724.3411058-1-daniel@0x0f.com> <20210215112409.1a755bf0@xps13>
 <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
 <20210215121653.4edd86c4@xps13> <CAFr9PXmVehtcm6FjBqi_hmEAj1rgtxMvarisjPmWhgjruVj++Q@mail.gmail.com>
 <20210322193213.18520b9a@xps13> <CAFr9PX=mL9UWcr-yWbYa5NXS-R=yHeGgM+hd_MKOa2XiBUAJOQ@mail.gmail.com>
 <20210323113233.3523d66b@xps13> <CAFr9PX=KMZuzp61Hq=2WdHyEzE=6J7HEPWZxPs7FEqiH-G8wFw@mail.gmail.com>
 <20210323150603.6b942a60@xps13>
In-Reply-To: <20210323150603.6b942a60@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 23 Mar 2021 23:14:48 +0900
Message-ID: <CAFr9PXnxvacKOf=n+Gt16BHdjwL2cUqr9ZD=A=YeSftYFYrKEA@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Tue, 23 Mar 2021 at 23:06, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > # nandbiterrs -i /dev/mtd1
> > incremental biterrors test
> > Successfully corrected 0 bit errors per subpage
> > Inserted biterror @ 0/5
> > Read reported 4 corrected bit errors
> > ECC failure, invalid data despite read success
>
> This is not a valid behavior. There is something wrong with the way ECC
> status is read/retrieved. The read should indeed report 4 corrected bit
> errors, but then the data should be valid. Here it means that the
> introduced error appears corrected but in fact is not.
>
> We need to understand what status are available and write the
> appropriate vendor code.

Ok. Glad we checked then :).
Before sending again I will recheck how the ECC status is read and fix that up.

Thanks,

Daniel
