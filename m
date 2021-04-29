Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76236E635
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhD2Hpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:45:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:22437 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2Hpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:45:32 -0400
IronPort-SDR: 9q6FmM0k+s8Dcss4FEoBHq0KQrHVYYgIztedyqtVhsVCHb9T2Ef0X8/4J/23tLK83eq33KvxCs
 QakkgtR4x2Mg==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="177059025"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="177059025"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 00:44:46 -0700
IronPort-SDR: Fck8zcPGfTIdbNi8rwJYHhFMf13oy99i4LidJBdlNxLyN+13lbwIjZkKar9k6EixwHzq3qte+Y
 Gm1ZIQAj4hwQ==
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="466251058"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 00:44:43 -0700
Subject: Re: [LKP] Re: [ext4] 21175ca434:
 mdadm-selftests.enchmarks/mdadm-selftests/tests/01r1fail.fail
To:     Theodore Ts'o <tytso@mit.edu>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, dm-devel@redhat.com
References: <20210427081539.GF32408@xsang-OptiPlex-9020>
 <YIlrJCdhVaFPdPgb@mit.edu>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <7f4f7ecd-13e3-b23e-6a0b-04122b98e6f2@intel.com>
Date:   Thu, 29 Apr 2021 15:43:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <YIlrJCdhVaFPdPgb@mit.edu>
Content-Type: multipart/mixed;
 boundary="------------E1240F1335C9503DDE59BEEE"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E1240F1335C9503DDE59BEEE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/28/21 10:03 PM, Theodore Ts'o wrote:
> (Hmm, why did you cc linux-km on this report?  I would have thought
> dm-devel would have made more sense?)
>
> On Tue, Apr 27, 2021 at 04:15:39PM +0800, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: 21175ca434c5d49509b73cf473618b01b0b85437 ("ext4: make prefetch_block_bitmaps default")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> in testcase: mdadm-selftests
>> version: mdadm-selftests-x86_64-5d518de-1_20201008
>> with following parameters:
>>
>> 	disk: 1HDD
>> 	test_prefix: 01r1
>> 	ucode: 0x21
> So this failure makes no sense to me.  Looking at the kmesg failure
> logs, it's failing in the md layer:
>
> kern  :info  : [   99.775514] md/raid1:md0: not clean -- starting background reconstruction
> kern  :info  : [   99.783372] md/raid1:md0: active with 3 out of 4 mirrors
> kern  :info  : [   99.789735] md0: detected capacity change from 0 to 37888
> kern  :info  : [   99.796216] md: resync of RAID array md0
> kern  :crit  : [   99.900450] md/raid1:md0: Disk failure on loop2, disabling device.
>                                md/raid1:md0: Operation continuing on 2 devices.
> kern  :crit  : [   99.918281] md/raid1:md0: Disk failure on loop1, disabling device.
>                                md/raid1:md0: Operation continuing on 1 devices.
> kern  :info  : [  100.835833] md: md0: resync interrupted.
> kern  :info  : [  101.852898] md: resync of RAID array md0
> kern  :info  : [  101.858347] md: md0: resync done.
> user  :notice: [  102.109684] /lkp/benchmarks/mdadm-selftests/tests/01r1fail... FAILED - see /var/tmp/01r1fail.log and /var/tmp/fail01r1fail.log for details
>
> The referenced commit just turns block bitmap prefetching in ext4.
> This should not cause md to failure; if so, that's an md bug, not an
> ext4 bug.  There should not be anything that the file system is doing
> that would cause the kernel to think there is a disk failure.
>
> By the way, the reproduction instructions aren't working currently:
>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp install                job.yaml  # job file is attached in this email
> This fails because lkp is trying to apply a patch which does not apply
> with the current version of the md tools.

Hi Ted,

Thanks for the feedback, yes, there's patch already be merged into mdadm,
we have removed it from our code.

>
>>          bin/lkp split-job --compatible job.yaml
>>          bin/lkp run                    compatible-job.yaml
> And the current versions lkp don't generate a compatible-job.yaml file
> when you run "lkp split-job --compatable"; instead it generates a new
> yaml file with a set of random characters to generate a unique name.
> (What Multics parlance would be called a "shriek name"[1] :-)

We have updated the steps to avoid misunderstanding.

>
> Since I was having trouble running the reproduction; could you send
> the /var/tmp/*fail.logs so we could have a bit more insight what is
> going on?

I attached the log file for your reference,
btw the test is from 
https://github.com/neilbrown/mdadm/blob/master/tests/01r1fail,
you may want to run it directly.

Best Regards,
Rong Chen

>
> Thanks!
>
> 					- Ted
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org


--------------E1240F1335C9503DDE59BEEE
Content-Type: text/plain; charset=UTF-8;
 name="log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="log"

KyAuIC9sa3AvYmVuY2htYXJrcy9tZGFkbS1zZWxmdGVzdHMvdGVzdHMvMDFyMWZhaWwKKysg
bWRhZG0gLUNSIC9kZXYvbWQwIC1sMSAtbjQgL2Rldi9sb29wMCAvZGV2L2xvb3AxIC9kZXYv
bG9vcDIgbWlzc2luZworKyBybSAtZiAvdmFyL3RtcC9zdGRlcnIKKysgY2FzZSAkKiBpbgor
KyBjYXNlICQqIGluCisrIGZvciBhcmdzIGluICQqCisrIFtbIC1DUiA9fiAvZGV2LyBdXQor
KyBmb3IgYXJncyBpbiAkKgorKyBbWyAvZGV2L21kMCA9fiAvZGV2LyBdXQorKyBbWyAvZGV2
L21kMCA9fiBtZCBdXQorKyBmb3IgYXJncyBpbiAkKgorKyBbWyAtbDEgPX4gL2Rldi8gXV0K
KysgZm9yIGFyZ3MgaW4gJCoKKysgW1sgLW40ID1+IC9kZXYvIF1dCisrIGZvciBhcmdzIGlu
ICQqCisrIFtbIC9kZXYvbG9vcDAgPX4gL2Rldi8gXV0KKysgW1sgL2Rldi9sb29wMCA9fiBt
ZCBdXQorKyAvbGtwL2JlbmNobWFya3MvbWRhZG0tc2VsZnRlc3RzL21kYWRtIC0temVybyAv
ZGV2L2xvb3AwCm1kYWRtOiBVbnJlY29nbmlzZWQgbWQgY29tcG9uZW50IGRldmljZSAtIC9k
ZXYvbG9vcDAKKysgZm9yIGFyZ3MgaW4gJCoKKysgW1sgL2Rldi9sb29wMSA9fiAvZGV2LyBd
XQorKyBbWyAvZGV2L2xvb3AxID1+IG1kIF1dCisrIC9sa3AvYmVuY2htYXJrcy9tZGFkbS1z
ZWxmdGVzdHMvbWRhZG0gLS16ZXJvIC9kZXYvbG9vcDEKbWRhZG06IFVucmVjb2duaXNlZCBt
ZCBjb21wb25lbnQgZGV2aWNlIC0gL2Rldi9sb29wMQorKyBmb3IgYXJncyBpbiAkKgorKyBb
WyAvZGV2L2xvb3AyID1+IC9kZXYvIF1dCisrIFtbIC9kZXYvbG9vcDIgPX4gbWQgXV0KKysg
L2xrcC9iZW5jaG1hcmtzL21kYWRtLXNlbGZ0ZXN0cy9tZGFkbSAtLXplcm8gL2Rldi9sb29w
MgptZGFkbTogVW5yZWNvZ25pc2VkIG1kIGNvbXBvbmVudCBkZXZpY2UgLSAvZGV2L2xvb3Ay
CisrIGZvciBhcmdzIGluICQqCisrIFtbIG1pc3NpbmcgPX4gL2Rldi8gXV0KKysgL2xrcC9i
ZW5jaG1hcmtzL21kYWRtLXNlbGZ0ZXN0cy9tZGFkbSAtLXF1aWV0IC1DUiAvZGV2L21kMCAt
bDEgLW40IC9kZXYvbG9vcDAgL2Rldi9sb29wMSAvZGV2L2xvb3AyIG1pc3NpbmcgLS1hdXRv
PXllcworKyBydj0wCisrIGNhc2UgJCogaW4KKysgY2F0IC92YXIvdG1wL3N0ZGVycgorKyBy
ZXR1cm4gMAorKyBjaGVjayByZXN5bmMKKysgY2FzZSAkMSBpbgorKyBjbnQ9NQorKyBncmVw
IC1zcSByZXN5bmMgL3Byb2MvbWRzdGF0CisrIG1kYWRtIC9kZXYvbWQwIC0tZmFpbCAvZGV2
L2xvb3AyCisrIHJtIC1mIC92YXIvdG1wL3N0ZGVycgorKyBjYXNlICQqIGluCisrIGNhc2Ug
JCogaW4KKysgL2xrcC9iZW5jaG1hcmtzL21kYWRtLXNlbGZ0ZXN0cy9tZGFkbSAtLXF1aWV0
IC9kZXYvbWQwIC0tZmFpbCAvZGV2L2xvb3AyCisrIHJ2PTAKKysgY2FzZSAkKiBpbgorKyBj
YXQgL3Zhci90bXAvc3RkZXJyCisrIHJldHVybiAwCisrIGNoZWNrIHJlc3luYworKyBjYXNl
ICQxIGluCisrIGNudD01CisrIGdyZXAgLXNxIHJlc3luYyAvcHJvYy9tZHN0YXQKKysgbWRh
ZG0gL2Rldi9tZDAgLS1mYWlsIC9kZXYvbG9vcDEKKysgcm0gLWYgL3Zhci90bXAvc3RkZXJy
CisrIGNhc2UgJCogaW4KKysgY2FzZSAkKiBpbgorKyAvbGtwL2JlbmNobWFya3MvbWRhZG0t
c2VsZnRlc3RzL21kYWRtIC0tcXVpZXQgL2Rldi9tZDAgLS1mYWlsIC9kZXYvbG9vcDEKKysg
cnY9MAorKyBjYXNlICQqIGluCisrIGNhdCAvdmFyL3RtcC9zdGRlcnIKKysgcmV0dXJuIDAK
Kysgc2xlZXAgMQorKyBjaGVjayBub3N5bmMKKysgY2FzZSAkMSBpbgorKyBzbGVlcCAwLjUK
KysgZ3JlcCAtc3EgLUUgJyhyZXN5bmN8cmVjb3Zlcnl8cmVzaGFwZSkgKj0nIC9wcm9jL21k
c3RhdAorKysgc2VkICcvXiAqXChbMC05XSpcKSBcLyBcMS9kJworKysgZ3JlcCAvIC9zeXMv
YmxvY2svbWQwL21kL3N5bmNfY29tcGxldGVkCisrIGluY29tcGxldGU9JzI0MzIgLyAzNzg4
OCcKKysgJ1snIC1uICcyNDMyIC8gMzc4ODgnICddJworKyBkaWUgJ3Jlc3luYyBvciByZWNv
dmVyeSBpcyBoYXBwZW5pbmchJworKyBlY2hvIC1lICdcblx0RVJST1I6IHJlc3luYyBvciBy
ZWNvdmVyeSBpcyBoYXBwZW5pbmchIFxuJwoKCUVSUk9SOiByZXN5bmMgb3IgcmVjb3Zlcnkg
aXMgaGFwcGVuaW5nISAKCisrIHNhdmVfbG9nIGZhaWwKKysgc3RhdHVzPWZhaWwKKysgbG9n
ZmlsZT1mYWlsMDFyMWZhaWwubG9nCisrIGNhdCAvdmFyL3RtcC9zdGRlcnIKKysgY3AgL3Zh
ci90bXAvbG9nIC92YXIvdG1wLzAxcjFmYWlsLmxvZworKyBlY2hvICcjIyBsa3AtaXZiLWQw
NDogc2F2aW5nIGRtZXNnLicKKysgZG1lc2cgLWMKKysgZWNobyAnIyMgbGtwLWl2Yi1kMDQ6
IHNhdmluZyBwcm9jIG1kc3RhdC4nCisrIGNhdCAvcHJvYy9tZHN0YXQKKysgYXJyYXk9KCQo
bWRhZG0gLURzIHwgY3V0IC1kJyAnIC1mMikpCisrKyBtZGFkbSAtRHMKKysrIHJtIC1mIC92
YXIvdG1wL3N0ZGVycgorKysgY3V0ICctZCAnIC1mMgorKysgY2FzZSAkKiBpbgorKysgY2Fz
ZSAkKiBpbgorKysgL2xrcC9iZW5jaG1hcmtzL21kYWRtLXNlbGZ0ZXN0cy9tZGFkbSAtLXF1
aWV0IC1EcworKysgcnY9MAorKysgY2FzZSAkKiBpbgorKysgY2F0IC92YXIvdG1wL3N0ZGVy
cgorKysgcmV0dXJuIDAKKysgJ1snIGZhaWwgPT0gZmFpbCAnXScKKysgZWNobyAnRkFJTEVE
IC0gc2VlIC92YXIvdG1wLzAxcjFmYWlsLmxvZyBhbmQgL3Zhci90bXAvZmFpbDAxcjFmYWls
LmxvZyBmb3IgZGV0YWlscycKRkFJTEVEIC0gc2VlIC92YXIvdG1wLzAxcjFmYWlsLmxvZyBh
bmQgL3Zhci90bXAvZmFpbDAxcjFmYWlsLmxvZyBmb3IgZGV0YWlscworKyAnWycgbG9vcCA9
PSBsdm0gJ10nCisrICdbJyBsb29wID09IGxvb3AgLW8gbG9vcCA9PSBkaXNrICddJworKyAn
WycgJyEnIC16IC9kZXYvbWQwIC1hIDEgLWdlIDEgJ10nCisrIGVjaG8gJyMjIGxrcC1pdmIt
ZDA0OiBtZGFkbSAtRCAvZGV2L21kMCcKKysgL2xrcC9iZW5jaG1hcmtzL21kYWRtLXNlbGZ0
ZXN0cy9tZGFkbSAtRCAvZGV2L21kMAorKyBjYXQgL3Byb2MvbWRzdGF0CisrIGdyZXAgLXEg
J2xpbmVhclx8ZXh0ZXJuYWwnCisrIG1kX2Rpc2tzPSgkKCRtZGFkbSAtRCAtWSAke2FycmF5
W0BdfSB8IGdyZXAgIi9kZXYvIiB8IGN1dCAtZCc9JyAtZjIpKQorKysgL2xrcC9iZW5jaG1h
cmtzL21kYWRtLXNlbGZ0ZXN0cy9tZGFkbSAtRCAtWSAvZGV2L21kMAorKysgZ3JlcCAvZGV2
LworKysgY3V0IC1kPSAtZjIKKysgY2F0IC9wcm9jL21kc3RhdAorKyBncmVwIC1xIGJpdG1h
cAorKyAnWycgMSAtZXEgMCAnXScKKysgZXhpdCAyCg==
--------------E1240F1335C9503DDE59BEEE--
