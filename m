Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75C43AA96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 05:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhJZDIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 23:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231445AbhJZDIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 23:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635217571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgZfLWj7RPfnAn/W2uAQwfMYaCeUPV0KjyENL3A9vM8=;
        b=fkdGCEu8pRJYssAtdP76yliyisG568rrUg74isg1KvbpjY/l+9PcGs1pmO6NMVjol3x886
        Dv15Qlqb5+dPn3J1v5i4+WWnns7+0AwPtE+Po4WQI9m2R+nwD+H6amOQAo/l5uIKRhGwFz
        qyPI0Xv40Dp9lNm963gw8iWNL4qH+pc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395--xZXXs4OOKaXB2XYYh5-9w-1; Mon, 25 Oct 2021 23:06:09 -0400
X-MC-Unique: -xZXXs4OOKaXB2XYYh5-9w-1
Received: by mail-pf1-f198.google.com with SMTP id y37-20020a056a00182500b0047c102c1ca2so417247pfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 20:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bgZfLWj7RPfnAn/W2uAQwfMYaCeUPV0KjyENL3A9vM8=;
        b=ExuF6VcYKFaUHqV2W5z6QQ6KnOgWLF47XRGLymhixRV0zeGJqj/ERNBwPEnOv9RKFa
         ZpK1ax4DYlFcmYML5P1wkzUlom57yfhb/IZDmWIhiOjzjIKxgFdZ4rbVCFCj3wN0vGxU
         3mo/iBNf3gJd14tdZcac8hormS5B8vFbt3iVVqKiYsqrAIu+WXCKwFTZrwtmIaDSOpuE
         s4nIGzLe3sne+8fwrUZE/g6Lo2bvmEy/zy18jIb/46FeUtRgpN3dJNQVdt3rU0djKTRs
         69AC1ThzWA6hadCrIg9mDNJAgQkUvJKnyvq9Cp9073EPDVzuNDhulr7kS54h+t+3Zkrn
         rITw==
X-Gm-Message-State: AOAM533PL6pYOh7ZZDKgWyUqYjbcSDqXTOwDIQApjw0FlF69zHfiu1UX
        tEUhG9TcbQwexRSa/mo/xk6WfhacETIMoU7sQAv6ViR6uClep9Bg5C4P0D6oJJZ0V0OL9gKYj4w
        n1cPLgy+GWaB6d219DqhTY4av7BuerbUAveKCs/Ds/k2n6YwRrwt28GJ/Jgr941bRgQEGli+jUg
        ==
X-Received: by 2002:a62:7c0b:0:b0:47b:df8d:816 with SMTP id x11-20020a627c0b000000b0047bdf8d0816mr17489654pfc.11.1635217568078;
        Mon, 25 Oct 2021 20:06:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWh1eQlGkKFSiSnyZ955TOkEvRh94YZpScVe05hDhVwUuLUubdbFrXIblKI+fZosICPRUWnQ==
X-Received: by 2002:a62:7c0b:0:b0:47b:df8d:816 with SMTP id x11-20020a627c0b000000b0047bdf8d0816mr17489613pfc.11.1635217567561;
        Mon, 25 Oct 2021 20:06:07 -0700 (PDT)
Received: from [10.72.12.93] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c4sm23523143pfv.144.2021.10.25.20.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 20:06:06 -0700 (PDT)
Subject: Re: [RFC PATCH] ceph: add remote object copy counter to fs client
To:     Patrick Donnelly <pdonnell@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
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
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <785d1435-4a2c-95aa-0573-2de54b4e7b6b@redhat.com>
Date:   Tue, 26 Oct 2021 11:05:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CA+2bHPYacg5yjO9otP5wUVxgwxw+d4hroVQod5VeFUTJNosQ9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/22/21 1:30 AM, Patrick Donnelly wrote:
> On Thu, Oct 21, 2021 at 12:35 PM Jeff Layton <jlayton@kernel.org> wrote:
>> On Thu, 2021-10-21 at 12:18 -0400, Patrick Donnelly wrote:
>>> On Thu, Oct 21, 2021 at 11:44 AM Jeff Layton <jlayton@kernel.org> wrote:
>>>> On Thu, 2021-10-21 at 09:52 -0400, Patrick Donnelly wrote:
>>>>> On Wed, Oct 20, 2021 at 12:27 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>>> On Wed, 2021-10-20 at 15:37 +0100, Luís Henriques wrote:
>>>>>>> This counter will keep track of the number of remote object copies done on
>>>>>>> copy_file_range syscalls.  This counter will be filesystem per-client, and
>>>>>>> can be accessed from the client debugfs directory.
>>>>>>>
>>>>>>> Cc: Patrick Donnelly <pdonnell@redhat.com>
>>>>>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>>>>>> ---
>>>>>>> This is an RFC to reply to Patrick's request in [0].  Note that I'm not
>>>>>>> 100% sure about the usefulness of this patch, or if this is the best way
>>>>>>> to provide the functionality Patrick requested.  Anyway, this is just to
>>>>>>> get some feedback, hence the RFC.
>>>>>>>
>>>>>>> Cheers,
>>>>>>> --
>>>>>>> Luís
>>>>>>>
>>>>>>> [0] https://github.com/ceph/ceph/pull/42720
>>>>>>>
>>>>>> I think this would be better integrated into the stats infrastructure.
>>>>>>
>>>>>> Maybe you could add a new set of "copy" stats to struct
>>>>>> ceph_client_metric that tracks the total copy operations done, their
>>>>>> size and latency (similar to read and write ops)?
>>>>> I think it's a good idea to integrate this into "stats" but I think a
>>>>> local debugfs file for some counters is still useful. The "stats"
>>>>> module is immature at this time and I'd rather not build any qa tests
>>>>> (yet) that rely on it.
>>>>>
>>>>> Can we generalize this patch-set to a file named "op_counters" or
>>>>> similar and additionally add other OSD ops performed by the kclient?
>>>>>
>>>>
>>>> Tracking this sort of thing is the main purpose of the stats code. I'm
>>>> really not keen on adding a whole separate set of files for reporting
>>>> this.
>>> Maybe I'm confused. Is there some "file" which is already used for
>>> this type of debugging information? Or do you mean the code for
>>> sending stats to the MDS to support cephfs-top?
>>>
>>>> What's the specific problem with relying on the data in debugfs
>>>> "metrics" file?
>>> Maybe no problem? I wasn't aware of a "metrics" file.
>>>
>> Yes. For instance:
>>
>> # cat /sys/kernel/debug/ceph/*/metrics
>> item                               total
>> ------------------------------------------
>> opened files  / total inodes       0 / 4
>> pinned i_caps / total inodes       5 / 4
>> opened inodes / total inodes       0 / 4
>>
>> item          total       avg_lat(us)     min_lat(us)     max_lat(us)     stdev(us)
>> -----------------------------------------------------------------------------------
>> read          0           0               0               0               0
>> write         5           914013          824797          1092343         103476
>> metadata      79          12856           1572            114572          13262
>>
>> item          total       avg_sz(bytes)   min_sz(bytes)   max_sz(bytes)  total_sz(bytes)
>> ----------------------------------------------------------------------------------------
>> read          0           0               0               0               0
>> write         5           4194304         4194304         4194304         20971520
>>
>> item          total           miss            hit
>> -------------------------------------------------
>> d_lease       11              0               29
>> caps          5               68              10702
>>
>>
>> I'm proposing that Luis add new lines for "copy" to go along with the
>> "read" and "write" ones. The "total" counter should give you a count of
>> the number of operations.
> Okay that makes more sense!
>
> Side note: I am a bit horrified by how computer-unfriendly that
> table-formatted data is.

Any suggestion to improve this ?

How about just make the "metric" file writable like a switch ? And as 
default it will show the data as above and if tools want the 
computer-friendly format, just write none-zero to it, then show raw data 
just like:

# cat /sys/kernel/debug/ceph/*/metrics
opened_files:0
pinned_i_caps:5
opened_inodes:0
total_inodes:4

read_latency:0,0,0,0,0
write_latency:5,914013,824797,1092343,103476
metadata_latency:79,12856,1572,114572,13262

read_size:0,0,0,0,0
write_size:5,4194304,4194304,4194304,20971520

d_lease:11,0,29
caps:5,68,10702


