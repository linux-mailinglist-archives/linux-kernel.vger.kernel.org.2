Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4D3422C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhCSRBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCSRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:01:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A00C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:01:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id u19so4094247pgh.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abcrisGGTGsUAWQ5KoqT7ElR97XBM2BFMqmIjep2vmg=;
        b=HvE8G3ao+LwRCd+a6Gbl1e2h4jfqTUv7r/eu7nd1o1eBKdfIirZ4kiJTFGW5x6y+/2
         8Ja4Zry3nJSBB3pa2Kubv5GA2G2tXdvQlRv0Y8OXN0ymGruB73rW8JGaJZ3RY7jHC7gM
         WJTBve7lV+PwmNe5lTBqrpZ+9f0UWBGRnj0JAETRoP5gnAdbx5uLwn+NZKz3cWXajcIO
         zTtA6I45Rh4X/d5FKNJp7teDWp9jO04MvAMx8OnhcX9YPdHiXFlTFtlym/A+Ky055eRq
         hqwGhWdnXAdLfDXoV09ITjh0E+s96TGw6cvPUq2eojChafTowplLiHSKN7avIBg6+nAi
         /Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abcrisGGTGsUAWQ5KoqT7ElR97XBM2BFMqmIjep2vmg=;
        b=OxeCh3HVjTGe85b+HS7x9XZHwT38ts//FmKb7VoWy5CpOv+eGUoAZ30PlGfICTTuBn
         KzH0QYQ2uDtCnDZFGOV1jXfRA4CZQxPlgGmqB3v1BRrmE8zqFNEH1zG7igYyQ6G/4Jm+
         Q1BMfTtY/Z3p0x0gPjKnRHHTI5oKmVIo3E8l9OraJmm08v//w3OyfM0kFyJBfX/I+2BM
         eqc+c//tXvzcO6asOE0sUmGPMn1m2DA46EQ5cPCYiBCPugBt36e/7naQ2QnEyP1rDVSr
         c6Ymj12Xt0Z15HXzLG2evVDQhH0rY72PzOQkt2YdwHdJJFzqVQmhZpO9HreLTTpiZE4B
         pUTQ==
X-Gm-Message-State: AOAM533HNtYOmd0AMa3xlaBNp50FwwZz2jA8CsMfwa6rRUnNnebUaJ0j
        Ww/VzaQj/HrWk2Qj5ykio2sISoiaoICkATuA1rsQaOAWKugVdA==
X-Google-Smtp-Source: ABdhPJzlLokuD5CVt4V1gtMOAmgeXqrksxJ6IMatvnRINYbOyNE/4DGODt/j0KH7js1AablTfParVLbL1d26YGFpxSQ=
X-Received: by 2002:a63:141e:: with SMTP id u30mr12548461pgl.31.1616173268970;
 Fri, 19 Mar 2021 10:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210316124903.35011-1-cristian.marussi@arm.com>
 <20210316124903.35011-26-cristian.marussi@arm.com> <CA+=V6c08cVmsCV_sDn5CogzbyN5KyNKL=u+WkAE0cPz2fqPhjQ@mail.gmail.com>
 <20210316222132.GA6875@e120937-lin> <CA+=V6c1=hWbF1_5wL7nMDK_CXqDVmgDXWvJjUC-XqZRGGewafA@mail.gmail.com>
 <20210318121202.6xf2lqm7udqvla24@bogus>
In-Reply-To: <20210318121202.6xf2lqm7udqvla24@bogus>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Fri, 19 Mar 2021 10:00:58 -0700
Message-ID: <CA+=V6c1j=Mbz4o_NpvMf7OgUkLVCZdqxgbq+1RMAHh8pNcyuMQ@mail.gmail.com>
Subject: Re: [PATCH v7 25/38] iio/scmi: port driver to the new
 scmi_sensor_proto_ops interface
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Guru Nagarajan <gurunagarajan@google.com>,
        Enrico Granata <egranata@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 iio/scmi: port driver to the new scmi_sensor_proto_ops interface

    Port driver to the new SCMI Sensor interface based on protocol handles
    and common devm_get_ops().

    Cc: Jyoti Bhayana <jbhayana@google.com>
    Cc: Jonathan Cameron <jic23@kernel.org>
    Acked-by: Jyoti Bhayana <jbhayana@google.com>
    Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>



On Thu, Mar 18, 2021 at 5:12 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Mar 16, 2021 at 10:38:43PM -0700, Jyoti Bhayana wrote:
> > Hi Christian,
> >
> > Thanks for the detailed explanation. Sounds good to me.
> >
>
> Can I get official Reviewed-by or Acked-by please if you are fine with the
> change ?
>
> I definitely need one from Jonathan to merge this and one from Jyoti is
> added bonus .
>
> --
> Regards,
> Sudeep
