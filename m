Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0883F43C331
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhJ0Gsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231232AbhJ0Gsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635317185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szpZWungLt188iGRJ7IS/k6GHDgjyNaBMaxf4CD4M/A=;
        b=KmuGEcrQ2+paUtrauIWXyBgAYSOteFVfWNhOJDjY85VIYHcu2Ci5Z5zbVnmy7ZZ4G0uc5M
        h804j8jzhG5xADCUmsukUPL0eFHs2JCatSfLxQp6wGF4s/ICv1MQw8wrt7SzHxWxt7jM9Y
        xvpDv6ndhMS6hf+jhKFEH2Ovx/oAfqg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-MqlU-LmwM6ivk5QQJlJm1g-1; Wed, 27 Oct 2021 02:46:24 -0400
X-MC-Unique: MqlU-LmwM6ivk5QQJlJm1g-1
Received: by mail-pg1-f198.google.com with SMTP id a18-20020a637f12000000b002a44c4f0e66so1108523pgd.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=szpZWungLt188iGRJ7IS/k6GHDgjyNaBMaxf4CD4M/A=;
        b=0A+vWYKF7czIf89DBmamwZb1O+WAVf/sZ65QcLgWHR8uIF3leo4vbUIVHtoG9KRDwh
         joFXhVCQ3pdJuw54Snn7z1wNgMx+8qiUqLdFmsOB/RYHqgQuRWK4ftsZZZ7BXFrS11mO
         nNlDKSow9tkBz5/0joIeKj+xeqheF5QA/Ib/3+PD2Mj21O5wOUpTCKfr3BR5C/NJV1DO
         gBxLVgYDZQiX8Kq6530AuTYpawKUOaLHRYQ3oZaejiEJa3h2Nr89KsLwAFkLSb7b+x8v
         93O/z/qbO1k6D3eLI0r8YL6BCvfYxxy4NibXXTN+e+uhVgJIL+9Jpu/p3jqt4m1GnnOs
         5zkQ==
X-Gm-Message-State: AOAM533C1F8+dwNfth35ESR5Qr9tpfeC2Y8+W1LbpZJcTUBAHDbib720
        mm1UXuFs7CHAEK62tJ80bHMCR0V2v6vyWFxrIMxsSigjJpjdz9HvfESf1HLUN1hTsrPiYZRXQIA
        kNI1MCUnij18soEmj3x16yQtYBpmu83/GhxnCCD/JmmS9cT8ZNqG/SDy3C1aJM85ILrr05npEUA
        ==
X-Received: by 2002:a63:69c4:: with SMTP id e187mr22696870pgc.379.1635317182369;
        Tue, 26 Oct 2021 23:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1/ePiB3RyVF7yzkvWkrpeK8zyncf0qhP9FQuBzIDoDnkT95X4+EnQ0HwOcTGyMo77bz/vyA==
X-Received: by 2002:a63:69c4:: with SMTP id e187mr22696840pgc.379.1635317181927;
        Tue, 26 Oct 2021 23:46:21 -0700 (PDT)
Received: from [10.72.12.93] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b10sm26122710pfl.200.2021.10.26.23.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 23:46:21 -0700 (PDT)
Subject: Re: [RFC PATCH] ceph: add remote object copy counter to fs client
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Patrick Donnelly <pdonnell@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211020143708.14728-1-lhenriques@suse.de>
 <34e379f9dec1cbdf09fffd8207f6ef7f4e1a6841.camel@kernel.org>
 <CA+2bHPbqeH_rmmxcnQ9gq0K8gqtE4q69a8cFnherSJCxSwXV5Q@mail.gmail.com>
 <99209198dd9d8634245f153a90e4091851635a16.camel@kernel.org>
 <CA+2bHPZTazVGtZygdbthQ-AWiC3AN_hsYouhVVs=PDo5iowgTw@mail.gmail.com>
 <e5627f7d9eb9cf2b753136e1187d5d6ff7789389.camel@kernel.org>
 <CA+2bHPYacg5yjO9otP5wUVxgwxw+d4hroVQod5VeFUTJNosQ9w@mail.gmail.com>
 <785d1435-4a2c-95aa-0573-2de54b4e7b6b@redhat.com>
 <604199ed389d9286e3fdab6b5acdf65c421df45d.camel@kernel.org>
 <YXgfUJ9aYrubADRQ@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <1ac925e3-5596-dcf4-317e-1408c764350f@redhat.com>
Date:   Wed, 27 Oct 2021 14:46:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YXgfUJ9aYrubADRQ@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/26/21 11:31 PM, Luís Henriques wrote:
> On Tue, Oct 26, 2021 at 07:40:51AM -0400, Jeff Layton wrote:
>> On Tue, 2021-10-26 at 11:05 +0800, Xiubo Li wrote:
>>> On 10/22/21 1:30 AM, Patrick Donnelly wrote:
>>>> On Thu, Oct 21, 2021 at 12:35 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>> On Thu, 2021-10-21 at 12:18 -0400, Patrick Donnelly wrote:
>>>>>> On Thu, Oct 21, 2021 at 11:44 AM Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>> On Thu, 2021-10-21 at 09:52 -0400, Patrick Donnelly wrote:
>>>>>>>> On Wed, Oct 20, 2021 at 12:27 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>>>> On Wed, 2021-10-20 at 15:37 +0100, Luís Henriques wrote:
>>>>>>>>>> This counter will keep track of the number of remote object copies done on
>>>>>>>>>> copy_file_range syscalls.  This counter will be filesystem per-client, and
>>>>>>>>>> can be accessed from the client debugfs directory.
>>>>>>>>>>
>>>>>>>>>> Cc: Patrick Donnelly <pdonnell@redhat.com>
>>>>>>>>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>>>>>>>>> ---
>>>>>>>>>> This is an RFC to reply to Patrick's request in [0].  Note that I'm not
>>>>>>>>>> 100% sure about the usefulness of this patch, or if this is the best way
>>>>>>>>>> to provide the functionality Patrick requested.  Anyway, this is just to
>>>>>>>>>> get some feedback, hence the RFC.
>>>>>>>>>>
>>>>>>>>>> Cheers,
>>>>>>>>>> --
>>>>>>>>>> Luís
>>>>>>>>>>
>>>>>>>>>> [0] https://github.com/ceph/ceph/pull/42720
>>>>>>>>>>
>>>>>>>>> I think this would be better integrated into the stats infrastructure.
>>>>>>>>>
>>>>>>>>> Maybe you could add a new set of "copy" stats to struct
>>>>>>>>> ceph_client_metric that tracks the total copy operations done, their
>>>>>>>>> size and latency (similar to read and write ops)?
>>>>>>>> I think it's a good idea to integrate this into "stats" but I think a
>>>>>>>> local debugfs file for some counters is still useful. The "stats"
>>>>>>>> module is immature at this time and I'd rather not build any qa tests
>>>>>>>> (yet) that rely on it.
>>>>>>>>
>>>>>>>> Can we generalize this patch-set to a file named "op_counters" or
>>>>>>>> similar and additionally add other OSD ops performed by the kclient?
>>>>>>>>
>>>>>>> Tracking this sort of thing is the main purpose of the stats code. I'm
>>>>>>> really not keen on adding a whole separate set of files for reporting
>>>>>>> this.
>>>>>> Maybe I'm confused. Is there some "file" which is already used for
>>>>>> this type of debugging information? Or do you mean the code for
>>>>>> sending stats to the MDS to support cephfs-top?
>>>>>>
>>>>>>> What's the specific problem with relying on the data in debugfs
>>>>>>> "metrics" file?
>>>>>> Maybe no problem? I wasn't aware of a "metrics" file.
>>>>>>
>>>>> Yes. For instance:
>>>>>
>>>>> # cat /sys/kernel/debug/ceph/*/metrics
>>>>> item                               total
>>>>> ------------------------------------------
>>>>> opened files  / total inodes       0 / 4
>>>>> pinned i_caps / total inodes       5 / 4
>>>>> opened inodes / total inodes       0 / 4
>>>>>
>>>>> item          total       avg_lat(us)     min_lat(us)     max_lat(us)     stdev(us)
>>>>> -----------------------------------------------------------------------------------
>>>>> read          0           0               0               0               0
>>>>> write         5           914013          824797          1092343         103476
>>>>> metadata      79          12856           1572            114572          13262
>>>>>
>>>>> item          total       avg_sz(bytes)   min_sz(bytes)   max_sz(bytes)  total_sz(bytes)
>>>>> ----------------------------------------------------------------------------------------
>>>>> read          0           0               0               0               0
>>>>> write         5           4194304         4194304         4194304         20971520
>>>>>
>>>>> item          total           miss            hit
>>>>> -------------------------------------------------
>>>>> d_lease       11              0               29
>>>>> caps          5               68              10702
>>>>>
>>>>>
>>>>> I'm proposing that Luis add new lines for "copy" to go along with the
>>>>> "read" and "write" ones. The "total" counter should give you a count of
>>>>> the number of operations.
>>>> Okay that makes more sense!
>>>>
>>>> Side note: I am a bit horrified by how computer-unfriendly that
>>>> table-formatted data is.
>>> Any suggestion to improve this ?
>>>
>>> How about just make the "metric" file writable like a switch ? And as
>>> default it will show the data as above and if tools want the
>>> computer-friendly format, just write none-zero to it, then show raw data
>>> just like:
>>>
>>> # cat /sys/kernel/debug/ceph/*/metrics
>>> opened_files:0
>>> pinned_i_caps:5
>>> opened_inodes:0
>>> total_inodes:4
>>>
>>> read_latency:0,0,0,0,0
>>> write_latency:5,914013,824797,1092343,103476
>>> metadata_latency:79,12856,1572,114572,13262
>>>
>>> read_size:0,0,0,0,0
>>> write_size:5,4194304,4194304,4194304,20971520
>>>
>>> d_lease:11,0,29
>>> caps:5,68,10702
>>>
>>>
>> I'd rather not multiplex the output of this file based on some input.
>> That would also be rather hard to do -- write() and read() are two
>> different syscalls, so you'd need to track a bool (or something) across
>> them somehow.
>>
>> Currently, I doubt there are many scripts in the field that scrape this
>> info and debugfs is specifically excluded from ABI concerns. If we want
>> to make it more machine-readable (which sounds like a good thing), then
>> I suggest we just change the output to something like what you have
>> above and not worry about preserving the "legacy" output.
> Ok, before submitting any new revision of this patch I should probably
> clean this up.  I can submit a patch to change the format to what Xiubo is
> proposing.  Obviously, that patch will also need to document what all
> those fields actually mean.
>
> Alternatively, the metrics file could be changed into a directory and have
> 4 different files, one per each section:
>
>    metrics/
>     |- files <-- not sure how to name the 1st section
>     |- latency
>     |- size
>     \- caps
>
> Each of these files would then have the header but, since it's a single
> header, parsing it in a script would be pretty easy.  The advantage is
> that this would be self-documented (with filenames and headers).

This sounds good to me.


>
> Cheers,
> --
> Luís
>

