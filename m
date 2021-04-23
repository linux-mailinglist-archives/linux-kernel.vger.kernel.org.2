Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29586368D83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbhDWHCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:02:08 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:43584 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:02:06 -0400
Received: by mail-wm1-f48.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso623567wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5BeObg8uOnhyHRYh5vbTyjx2+E85Q4vpwfukG+nYgP4=;
        b=MqHCUutkkoQpEvspq1120chiSCfluX6k+xtltro4bRCKm+WNivPzdvHxnnpq6goZaq
         HgZra7cse6bwc+vBRTTrnoXCQcInU31KX/JbNae0Dg7Stkzh5QppVhQd+shs/VI75BUj
         32B8DOSYy/E3276bQuDk0wckVAvm985DJDZYhDjwzZ4T2ho2kmCBchrD8BX3CXm60Rrn
         KXt382Qrx4iDqbDxS3rB0q1w4G7+1ZnsLBJB486/aLGjLKSCA/SNZdUuf3FOdC/J9pQu
         4YUkEHkN5GcUnr1AzJqJOP6v6UXovDhOM/MUCvoVetvb8UeGo3hwhhvcbrsURyTmVRME
         NrwQ==
X-Gm-Message-State: AOAM5323vKln5eLjwK1KMyM2/BiBdcsNZ3DyyZEpMc+WWjpv58GjTi6k
        Xdtssol41CInCyHWIH9zYbU=
X-Google-Smtp-Source: ABdhPJz7DWctLJemiTEGVYhKtAZ7+PbjmpaBra5QsKUMRvTPPWMmINRIo1LOhwi4RYI3c26CRQG9sQ==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr4035146wmi.24.1619161288665;
        Fri, 23 Apr 2021 00:01:28 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.googlemail.com with ESMTPSA id a7sm7702415wrn.50.2021.04.23.00.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 00:01:27 -0700 (PDT)
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <jikos@kernel.org>, Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421180155.GA2287172@nvidia.com>
 <18edc472a95f1d4efe3ef40cc9b8d2611d4ab990.camel@redhat.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <6b19f57c-8d4f-ef3f-9792-f52900137522@kernel.org>
Date:   Fri, 23 Apr 2021 09:01:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <18edc472a95f1d4efe3ef40cc9b8d2611d4ab990.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2021 20:53, Doug Ledford wrote:
> On Wed, 2021-04-21 at 15:01 -0300, Jason Gunthorpe wrote:
>> On Wed, Apr 21, 2021 at 02:57:55PM +0200, Greg Kroah-Hartman wrote:
>>> I have been meaning to do this for a while, but recent events have
>>> finally forced me to do so.
>>>
>>> Commits from @umn.edu addresses have been found to be submitted in
>>> "bad
>>> faith" to try to test the kernel community's ability to review
>>> "known
>>> malicious" changes.  The result of these submissions can be found in
>>> a
>>> paper published at the 42nd IEEE Symposium on Security and Privacy
>>> entitled, "Open Source Insecurity: Stealthily Introducing
>>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu
>>> (University
>>> of Minnesota) and Kangjie Lu (University of Minnesota).
>>
>> I noted in the paper it says:
>>
>>   A. Ethical Considerations
>>
>>   Ensuring the safety of the experiment. In the experiment, we aim to
>>   demonstrate the practicality of stealthily introducing
>> vulnerabilities
>>   through hypocrite commits. Our goal is not to introduce
>>   vulnerabilities to harm OSS. Therefore, we safely conduct the
>>   experiment to make sure that the introduced UAF bugs will not be
>>   merged into the actual Linux code
>>
>> So, this revert is based on not trusting the authors to carry out
>> their work in the manner they explained?
>>
>> From what I've reviewed, and general sentiment of other people's
>> reviews I've read, I am concerned this giant revert will degrade
>> kernel quality more than the experimenters did - especially if they
>> followed their stated methodology.
> 
> I have to agree with Jason.  This seems like trying to push a thumbtack
> into a bulletin board using a pyle driver.  Unless the researchers are
> lying (which I've not seen a clear indication of), the 190 patches you
> have selected here are nothing more than collateral damage while you are
> completely missing the supposed patch submission addresses from which
> the malicious patches were sent!
> 
> This all really sounds like a knee-jerk reaction to thier posting.  I
> have to say, I think it's the wrong reaction to have.

Nothing stops you from participating in the review of this
revert-series, if you think these are valuable commits. Patches getting
the review, won't be reverted (as I understood).


Best regards,
Krzysztof
