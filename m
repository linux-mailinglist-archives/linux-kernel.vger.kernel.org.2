Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7892C3261ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhBZLXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230107AbhBZLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614338530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFz5i37rqgxdlak3BUpsEVKF5RFJ7HeoRxmzcOPQc6w=;
        b=BAYHNdoj0u/mkRmfsXAJgZHeovmj1XXpwiWauA9lN0z69Fhf+8IxQWM4ekb88WjwWiabTj
        nDh1GrjPFdf0UGhoEN1wPcTLvss4sZopyY3Zwn/dbsd+c/4WA8KwJSg4ePtFurrH5wbuVu
        Ruudk4HFztLfeT0kGeGKldHVyMuILBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-4nnZXRUaNzK_KcPAJp6NOQ-1; Fri, 26 Feb 2021 06:22:06 -0500
X-MC-Unique: 4nnZXRUaNzK_KcPAJp6NOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57570185A0CE;
        Fri, 26 Feb 2021 11:22:03 +0000 (UTC)
Received: from [10.36.113.8] (ovpn-113-8.ams2.redhat.com [10.36.113.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3BEC5D9D2;
        Fri, 26 Feb 2021 11:21:59 +0000 (UTC)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Hanjun Guo <guohanjun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Huxinwei <huxinwei@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yanjin <yanjin.yan@huawei.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Zhaohongjiang <zhaohongjiang@huawei.com>,
        "Zhangdianfang (Dianfang, OS Lab)" <zhangdianfang@huawei.com>,
        PEIXIN HOU <PEIXIN.HOU@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernelci@groups.io, Wei Yongjun <weiyongjun1@huawei.com>,
        Lijinyue <lijinyue@huawei.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <595affb4-36e8-0a63-ebb3-a4fd0e3c243a@huawei.com>
 <2a7ff382-1d35-0eeb-6fb6-bad37aa4c1d7@redhat.com>
 <4abea94d-5232-19ab-3139-569e485403b3@huawei.com>
From:   Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Message-ID: <a8518d24-8b02-39f7-d4e3-82c28715191d@redhat.com>
Date:   Fri, 26 Feb 2021 13:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4abea94d-5232-19ab-3139-569e485403b3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanjun,

On 2/26/21 10:03 AM, Hanjun Guo wrote:
 > On 2021/2/19 22:45, Nikolai Kondrashov wrote:
 >> Would you be interested in working with the Linux Foundation KernelCI project
 >> on submitting your build and test results to the common database - KCIDB?
 >
 > Yes, we are willing to sent the test results to KCIDB.

Wonderful!

 > For now, all the tests are inside the company, which blocks us to
 > directly sent the test results out of the test machine due to the
 > security policy, it takes us sometime to discuss how to send out
 > the test results, and we may need do the test in a public cloud.

I understand. We faced the same dilemma at Red Hat with the CKI project, where
I'm employed. In the end we just decided to publish the logs from the test
lab (most sensitive part, I suppose) as they are, but then Red Hat is already
a very open company.

Here's an example of all logs we publish for a revision:

     https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/02/22/624489

And here's that revision in KCIDB:

     https://staging.kernelci.org:3000/d/revision/revision?orgId=1&var-dataset=kernelci04&var-id=093ae67c90a629599a0cb2300c5686ec7d8bbdd0

Take your time, there is a range of solutions to choose from, starting from
isolating your test machines/boards, to running the test in the public cloud
as you mention. Although the latter lacks the benefit of testing your own
hardware, of course.

Please also note that we require the tested kernel's code to be publicly
available to accept results.

 >> We are working on aggregating results from various testing systems so we can
 >> provide a dashboard, and a single, aggregated e-mail report to subscribed
 >> maintainers and developers.
 >>
 >> We have a prototype dashboard at https://staging.kernelci.org:3000/ and are
 >> working hard on making the e-mail reports good enough to start reaching out to
 >> maintainers.
 >>
 >> We already have ARM, Google Syzbot, Gentoo GKernelCI, Red Hat CKI, and, of
 >> course, KernelCI native tests sending data to the database. Linaro Tuxsuite is
 >> starting sending today. We could use your data, and of course any development
 >> help you could spare :)
 >
 > How can we connect to the KCIDB? Can we send the test data out by email
 > first?

The simplest way would be using our "kcidb-submit" command-line tool.

Here's a minimal example of sending an empty report:

     echo '{"version":{"major":3,"minor":0}}' |
             kcidb-submit -p kernelci-production -t kernelci_new

Another way could be using our Python 3 library, which is a little more
involved. Here's an example sending the same empty report in Python:

     import kcidb
     client = kcidb.Client(project_id="kernelci-production",
                           topic_name="kernelci_new")
     client.submit({"version":{"major":3,"minor":0}})

Finally, you can send (validated) data using the Google Cloud Pub/Sub service
directly, using the library in one of the supported languages:

     https://cloud.google.com/pubsub/docs/tutorials

The latter would be the least stable option (change-wise), but something e.g.
Google Syzbot is already using.

See more details in our Submission HOWTO:

     https://github.com/kernelci/kcidb/blob/main/SUBMISSION_HOWTO.md

Although email submissions are theoretically possible (with due
authentication, setup, etc.), they're not currently supported, and we would
not put them at the top of our (rather large) priority list. Topmost item
being getting the data we already have to developers.

Would be excited to have you on board!
Nick

On 2/26/21 10:03 AM, Hanjun Guo wrote:
 > Hi Nick,
 >
 > Sorry for taking so long to reply you, we had discussions on how to
 > corporate with KCIDB, please see my comments inline.
 >
 > On 2021/2/19 22:45, Nikolai Kondrashov wrote:
 >> Hi Hanjun,
 >>
 >> On 2/19/21 10:54 AM, Hanjun Guo wrote:
 >>  > In specific, we will start from the testing work, using HULK robot
 >>  > (reports lots of bugs to mainline kernel) testing framework to test
 >>  > compile, reboot, functional testing, and will extend to basic
 >>  > performance regression testing in the future.
 >>
 >> I heard about Huawei ramping up kernel testing from someone at FOSDEM
 >> 2019. I wonder if it was you :) Nice to see your progress and the company
 >> stepping up to help with testing!
 >
 > I Cced Yongjun and Jinyue, they are the key persons :)
 >
 >>
 >> Would you be interested in working with the Linux Foundation KernelCI project
 >> on submitting your build and test results to the common database - KCIDB?
 >
 > Yes, we are willing to sent the test results to KCIDB.
 >
 > For now, all the tests are inside the company, which blocks us to
 > directly sent the test results out of the test machine due to the
 > security policy, it takes us sometime to discuss how to send out
 > the test results, and we may need do the test in a public cloud.
 >
 >>
 >> We are working on aggregating results from various testing systems so we can
 >> provide a dashboard, and a single, aggregated e-mail report to subscribed
 >> maintainers and developers.
 >>
 >> We have a prototype dashboard at https://staging.kernelci.org:3000/ and are
 >> working hard on making the e-mail reports good enough to start reaching out to
 >> maintainers.
 >>
 >> We already have ARM, Google Syzbot, Gentoo GKernelCI, Red Hat CKI, and, of
 >> course, KernelCI native tests sending data to the database. Linaro Tuxsuite is
 >> starting sending today. We could use your data, and of course any development
 >> help you could spare :)
 >
 > How can we connect to the KCIDB? Can we send the test data out by email
 > first?
 >
 >>
 >> I wish I could show you my today's KCIDB presentation at DevConf.cz, but the
 >> recording is not out yet. Meanwhile you can take a look at our presentation at
 >> last year's Linux Plumbers: https://youtu.be/y9Glc90WUN0?t=10739
 >>
 >> Or see our intro in an older blog post:
 >> https://foundation.kernelci.org/blog/2020/08/21/introducing-common-reporting/
 >>
 >> Anyone wishing to contribute to KCIDB gets credentials and permissions to
 >> submit to our "playground" setup where they can send their data, see it in a
 >> dashboard, experiment without worrying about breaking anything, and decide if
 >> they like it or n >
 >> If you're interested, take a look at our Submission HOWTO:
 >> https://github.com/kernelci/kcidb/blob/v8/SUBMISSION_HOWTO.md
 >> and send an email to kernelci@groups.io (CC'd), or come over to the #kernelci
 >> channel on freenode.net!
 >
 > Thanks!
 > Hanjun

