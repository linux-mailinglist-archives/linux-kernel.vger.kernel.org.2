Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4383D362A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245137AbhDPVsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:48:08 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:35412 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbhDPVsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:48:07 -0400
Received: by mail-io1-f41.google.com with SMTP id h141so20717731iof.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I310BGSKkXfzg5NOmiEVbhhSAhpSkpByfYWqfBgc2TA=;
        b=dSET+nmuZvnUkwuhG+gI2k9nGLt3bgMHrPSRrHRLH6qW8QYQL45Y5l1p6HhBViF14n
         nCoCXAl8kTxvivqaTtU/+USjahaD9ILHG1rDOH/pZtF1zN5grywnT+0fwW51cSVPoaby
         ZFlcZENl5+iIrc48o4nUQSfKld+nUXAImx0WRBiQVcCIFIcYkYOygx5HxtpBP1sD8uFM
         pRa8F54Fd64P3BhwlCMZuu6fgyPvked3dQTwi6GMTGqEi5yI1m/G2sX599FGGWj096Vb
         uPafsCDcBa/Btun1+k+MxFqNVqjTlhmLdzHr1bvbAYJbd3VsqycYLnOhOCIr/eBGYhNm
         QVzA==
X-Gm-Message-State: AOAM533IKGqva+TaArpzVdAO+3QdrfpUiHSFDFootsglsJDoBVgcDkRk
        ijOnd6RDCCv4zywHMiUXnkc=
X-Google-Smtp-Source: ABdhPJxspaYKBOLF+wC4UMmccnYjgO2lgyxemZfQD0OMmQsE7O3FQ9MbD3qAv2q2KG0+NK5SZKyi3g==
X-Received: by 2002:a5d:8893:: with SMTP id d19mr5313330ioo.167.1618609660742;
        Fri, 16 Apr 2021 14:47:40 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id e17sm3249461ilq.21.2021.04.16.14.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:47:40 -0700 (PDT)
Date:   Fri, 16 Apr 2021 21:47:37 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pratik.r.sampat@gmail.com
Subject: Re: [PATCH v3 0/6] percpu: partial chunk depopulation
Message-ID: <YHoF+XfC8Ul2/KPj@google.com>
References: <20210408035736.883861-1-guro@fb.com>
 <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
 <YHmcorqNE5NpAN3G@google.com>
 <7a001bf6-5708-fb04-4970-367d9845ccb9@linux.ibm.com>
 <YHnFsL2G2bpOH8ML@carbon.dhcp.thefacebook.com>
 <8ea7c616-95e8-e391-5373-ebaf10836d2c@linux.ibm.com>
 <YHnYqMdyYtIdab6n@carbon.dhcp.thefacebook.com>
 <09a8d1eb-280d-9ee9-3d68-d065db47a516@linux.ibm.com>
 <YHng5nAPSLJHnRY9@carbon.dhcp.thefacebook.com>
 <2a0d371d-79f6-e7aa-6dcd-3b29264e1feb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a0d371d-79f6-e7aa-6dcd-3b29264e1feb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Apr 17, 2021 at 01:14:03AM +0530, Pratik Sampat wrote:
> 
> 
> On 17/04/21 12:39 am, Roman Gushchin wrote:
> > On Sat, Apr 17, 2021 at 12:11:37AM +0530, Pratik Sampat wrote:
> > > 
> > > On 17/04/21 12:04 am, Roman Gushchin wrote:
> > > > On Fri, Apr 16, 2021 at 11:57:03PM +0530, Pratik Sampat wrote:
> > > > > On 16/04/21 10:43 pm, Roman Gushchin wrote:
> > > > > > On Fri, Apr 16, 2021 at 08:58:33PM +0530, Pratik Sampat wrote:
> > > > > > > Hello Dennis,
> > > > > > > 
> > > > > > > I apologize for the clutter of logs before, I'm pasting the logs of before and
> > > > > > > after the percpu test in the case of the patchset being applied on 5.12-rc6 and
> > > > > > > the vanilla kernel 5.12-rc6.
> > > > > > > 
> > > > > > > On 16/04/21 7:48 pm, Dennis Zhou wrote:
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
> > > > > > > > > Hello Roman,
> > > > > > > > > 
> > > > > > > > > I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
> > > > > > > > > 
> > > > > > > > > My results of the percpu_test are as follows:
> > > > > > > > > Intel KVM 4CPU:4G
> > > > > > > > > Vanilla 5.12-rc6
> > > > > > > > > # ./percpu_test.sh
> > > > > > > > > Percpu:             1952 kB
> > > > > > > > > Percpu:           219648 kB
> > > > > > > > > Percpu:           219648 kB
> > > > > > > > > 
> > > > > > > > > 5.12-rc6 + with patchset applied
> > > > > > > > > # ./percpu_test.sh
> > > > > > > > > Percpu:             2080 kB
> > > > > > > > > Percpu:           219712 kB
> > > > > > > > > Percpu:            72672 kB
> > > > > > > > > 
> > > > > > > > > I'm able to see improvement comparable to that of what you're see too.
> > > > > > > > > 
> > > > > > > > > However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
> > > > > > > > > 
> > > > > > > > > POWER9 KVM 4CPU:4G
> > > > > > > > > Vanilla 5.12-rc6
> > > > > > > > > # ./percpu_test.sh
> > > > > > > > > Percpu:             5888 kB
> > > > > > > > > Percpu:           118272 kB
> > > > > > > > > Percpu:           118272 kB
> > > > > > > > > 
> > > > > > > > > 5.12-rc6 + with patchset applied
> > > > > > > > > # ./percpu_test.sh
> > > > > > > > > Percpu:             6144 kB
> > > > > > > > > Percpu:           119040 kB
> > > > > > > > > Percpu:           119040 kB
> > > > > > > > > 
> > > > > > > > > I'm wondering if there's any architectural specific code that needs plumbing
> > > > > > > > > here?
> > > > > > > > > 
> > > > > > > > There shouldn't be. Can you send me the percpu_stats debug output before
> > > > > > > > and after?
> > > > > > > I'll paste the whole debug stats before and after here.
> > > > > > > 5.12-rc6 + patchset
> > > > > > > -----BEFORE-----
> > > > > > > Percpu Memory Statistics
> > > > > > > Allocation Info:
> > > > > > Hm, this looks highly suspicious. Here is your stats in a more compact form:
> > > > > > 
> > > > > > Vanilla
> > > > > > 
> > > > > > nr_alloc            :         9038         nr_alloc            :        97046
> > > > > > nr_dealloc          :         6992	   nr_dealloc          :        94237
> > > > > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2809
> > > > > > nr_max_alloc        :         2178	   nr_max_alloc        :        90054
> > > > > > nr_chunks           :            3	   nr_chunks           :           11
> > > > > > nr_max_chunks       :            3	   nr_max_chunks       :           47
> > > > > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > > > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > > > > empty_pop_pages     :            5	   empty_pop_pages     :           29
> > > > > > 
> > > > > > 
> > > > > > Patched
> > > > > > 
> > > > > > nr_alloc            :         9040         nr_alloc            :        97048
> > > > > > nr_dealloc          :         6994	   nr_dealloc          :        95002
> > > > > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2046
> > > > > > nr_max_alloc        :         2208	   nr_max_alloc        :        90054
> > > > > > nr_chunks           :            3	   nr_chunks           :           48
> > > > > > nr_max_chunks       :            3	   nr_max_chunks       :           48
> > > > > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > > > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > > > > empty_pop_pages     :           12	   empty_pop_pages     :           61
> > > > > > 
> > > > > > 
> > > > > > So it looks like the number of chunks got bigger, as well as the number of
> > > > > > empty_pop_pages? This contradicts to what you wrote, so can you, please, make
> > > > > > sure that the data is correct and we're not messing two cases?
> > > > > > 
> > > > > > So it looks like for some reason sidelined (depopulated) chunks are not getting
> > > > > > freed completely. But I struggle to explain why the initial empty_pop_pages is
> > > > > > bigger with the same amount of chunks.
> > > > > > 
> > > > > > So, can you, please, apply the following patch and provide an updated statistics?
> > > > > Unfortunately, I'm not completely well versed in this area, but yes the empty
> > > > > pop pages number doesn't make sense to me either.
> > > > > 
> > > > > I re-ran the numbers trying to make sure my experiment setup is sane but
> > > > > results remain the same.
> > > > > 
> > > > > Vanilla
> > > > > nr_alloc            :         9040         nr_alloc            :        97048
> > > > > nr_dealloc          :         6994	   nr_dealloc          :        94404
> > > > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2644
> > > > > nr_max_alloc        :         2169	   nr_max_alloc        :        90054
> > > > > nr_chunks           :            3	   nr_chunks           :           10
> > > > > nr_max_chunks       :            3	   nr_max_chunks       :           47
> > > > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > > > empty_pop_pages     :            4	   empty_pop_pages     :           32
> > > > > 
> > > > > With the patchset + debug patch the results are as follows:
> > > > > Patched
> > > > > 
> > > > > nr_alloc            :         9040         nr_alloc            :        97048
> > > > > nr_dealloc          :         6994	   nr_dealloc          :        94349
> > > > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2699
> > > > > nr_max_alloc        :         2194	   nr_max_alloc        :        90054
> > > > > nr_chunks           :            3	   nr_chunks           :           48
> > > > > nr_max_chunks       :            3	   nr_max_chunks       :           48
> > > > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > > > empty_pop_pages     :           12	   empty_pop_pages     :           54
> > > > > 
> > > > > With the extra tracing I can see 39 entries of "Chunk (sidelined)"
> > > > > after the test was run. I don't see any entries for "Chunk (to depopulate)"
> > > > > 
> > > > > I've snipped the results of slidelined chunks because they went on for ~600
> > > > > lines, if you need the full logs let me know.
> > > > Yes, please! That's the most interesting part!
> > > Got it. Pasting the full logs of after the percpu experiment was completed
> > Thanks!
> > 
> > Would you mind to apply the following patch and test again?
> > 
> > --
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index ded3a7541cb2..532c6a7ebdfd 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -2296,6 +2296,9 @@ void free_percpu(void __percpu *ptr)
> >                                  need_balance = true;
> >                                  break;
> >                          }
> > +
> > +               chunk->depopulated = false;
> > +               pcpu_chunk_relocate(chunk, -1);
> >          } else if (chunk != pcpu_first_chunk && chunk != pcpu_reserved_chunk &&
> >                     !chunk->isolated &&
> >                     (pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
> > 
> Sure thing.
> 
> I see much lower sideline chunks. In one such test run I saw zero occurrences
> of slidelined chunks
> 
> Pasting the full logs as an example:
> 
> BEFORE
> Percpu Memory Statistics
> Allocation Info:
> ----------------------------------------
>   unit_size           :       655360
>   static_size         :       608920
>   reserved_size       :            0
>   dyn_size            :        46440
>   atom_size           :        65536
>   alloc_size          :       655360
> 
> Global Stats:
> ----------------------------------------
>   nr_alloc            :         9038
>   nr_dealloc          :         6992
>   nr_cur_alloc        :         2046
>   nr_max_alloc        :         2200
>   nr_chunks           :            3
>   nr_max_chunks       :            3
>   min_alloc_size      :            4
>   max_alloc_size      :         1072
>   empty_pop_pages     :           12
> 
> Per Chunk Stats:
> ----------------------------------------
> Chunk: <- First Chunk
>   nr_alloc            :         1092
>   max_alloc_size      :         1072
>   empty_pop_pages     :            0
>   first_bit           :        16247
>   free_bytes          :            4
>   contig_bytes        :            4
>   sum_frag            :            4
>   max_frag            :            4
>   cur_min_alloc       :            4
>   cur_med_alloc       :            8
>   cur_max_alloc       :         1072
>   memcg_aware         :            0
> 
> Chunk:
>   nr_alloc            :          594
>   max_alloc_size      :          992
>   empty_pop_pages     :            8
>   first_bit           :          456
>   free_bytes          :       645008
>   contig_bytes        :       319984
>   sum_frag            :       325024
>   max_frag            :       318680
>   cur_min_alloc       :            4
>   cur_med_alloc       :            8
>   cur_max_alloc       :          424
>   memcg_aware         :            0
> 
> Chunk:
>   nr_alloc            :          360
>   max_alloc_size      :         1072
>   empty_pop_pages     :            4
>   first_bit           :        26595
>   free_bytes          :       506640
>   contig_bytes        :       506540
>   sum_frag            :          100
>   max_frag            :           32
>   cur_min_alloc       :            4
>   cur_med_alloc       :          156
>   cur_max_alloc       :         1072
>   memcg_aware         :            1
> 
> 
> AFTER
> Percpu Memory Statistics
> Allocation Info:
> ----------------------------------------
>   unit_size           :       655360
>   static_size         :       608920
>   reserved_size       :            0
>   dyn_size            :        46440
>   atom_size           :        65536
>   alloc_size          :       655360
> 
> Global Stats:
> ----------------------------------------
>   nr_alloc            :        97046
>   nr_dealloc          :        94304
>   nr_cur_alloc        :         2742
>   nr_max_alloc        :        90054
>   nr_chunks           :           11
>   nr_max_chunks       :           47
>   min_alloc_size      :            4
>   max_alloc_size      :         1072
>   empty_pop_pages     :           18
> 
> Per Chunk Stats:
> ----------------------------------------
> Chunk: <- First Chunk
>   nr_alloc            :         1092
>   max_alloc_size      :         1072
>   empty_pop_pages     :            0
>   first_bit           :        16247
>   free_bytes          :            4
>   contig_bytes        :            4
>   sum_frag            :            4
>   max_frag            :            4
>   cur_min_alloc       :            4
>   cur_med_alloc       :            8
>   cur_max_alloc       :         1072
>   memcg_aware         :            0
> 
> Chunk:
>   nr_alloc            :          838
>   max_alloc_size      :         1072
>   empty_pop_pages     :            7
>   first_bit           :          464
>   free_bytes          :       640476
>   contig_bytes        :       290672
>   sum_frag            :       349804
>   max_frag            :       304344
>   cur_min_alloc       :            4
>   cur_med_alloc       :            8
>   cur_max_alloc       :         1072
>   memcg_aware         :            0
> 
> Chunk:
>   nr_alloc            :           90
>   max_alloc_size      :         1072
>   empty_pop_pages     :            0
>   first_bit           :          536
>   free_bytes          :       595752
>   contig_bytes        :        26164
>   sum_frag            :       575132
>   max_frag            :        26164
>   cur_min_alloc       :          156
>   cur_med_alloc       :         1072
>   cur_max_alloc       :         1072
>   memcg_aware         :            1
> 
> Chunk:
>   nr_alloc            :           90
>   max_alloc_size      :         1072
>   empty_pop_pages     :            0
>   first_bit           :            0
>   free_bytes          :       597428
>   contig_bytes        :        26164
>   sum_frag            :       596848
>   max_frag            :        26164
>   cur_min_alloc       :          156
>   cur_med_alloc       :          312
>   cur_max_alloc       :         1072
>   memcg_aware         :            1
> 
> Chunk:
>   nr_alloc            :           92
>   max_alloc_size      :         1072
>   empty_pop_pages     :            0
>   first_bit           :            0
>   free_bytes          :       595284
>   contig_bytes        :        26164
>   sum_frag            :       590360
>   max_frag            :        26164
>   cur_min_alloc       :          156
>   cur_med_alloc       :          312
>   cur_max_alloc       :         1072
>   memcg_aware         :            1
> 
> Chunk:
>   nr_alloc            :           92
>   max_alloc_size      :         1072
>   empty_pop_pages     :            0
>   first_bit           :            0
>   free_bytes          :       595284
>   contig_bytes        :        26164
>   sum_frag            :       583768
>   max_frag            :        26164
>   cur_min_alloc       :          156
>   cur_med_alloc       :          312
>   cur_max_alloc       :         1072
>   memcg_aware         :            1
> 
> Chunk:
>   nr_alloc            :          360
>   max_alloc_size      :         1072
>   empty_pop_pages     :            7
>   first_bit           :        26595
>   free_bytes          :       506640
>   contig_bytes        :       506540
>   sum_frag            :          100
>   max_frag            :           32
>   cur_min_alloc       :            4
>   cur_med_alloc       :          156
>   cur_max_alloc       :         1072
>   memcg_aware         :            1
> 
> Chunk:
>   nr_alloc            :           12
>   max_alloc_size      :         1072
>   empty_pop_pages     :            3
>   first_bit           :            0
>   free_bytes          :       647524
>   contig_bytes        :       563492
>   sum_frag            :        57872
>   max_frag            :        26164
>   cur_min_alloc       :          156
>   cur_med_alloc       :          312
>   cur_max_alloc       :         1072
>   memcg_aware         :            1
> 
> Chunk:
>   nr_alloc            :            0
>   max_alloc_size      :         1072
>   empty_pop_pages     :            1
>   first_bit           :            0
>   free_bytes          :       655360
>   contig_bytes        :       655360
>   sum_frag            :            0
>   max_frag            :            0
>   cur_min_alloc       :            0
>   cur_med_alloc       :            0
>   cur_max_alloc       :            0
>   memcg_aware         :            1
> 
> Chunk (sidelined):
>   nr_alloc            :           72
>   max_alloc_size      :         1072
>   empty_pop_pages     :            0
>   first_bit           :            0
>   free_bytes          :       608344
>   contig_bytes        :       145552
>   sum_frag            :       590340
>   max_frag            :       145552
>   cur_min_alloc       :          156
>   cur_med_alloc       :          312
>   cur_max_alloc       :         1072
>   memcg_aware         :            1
> 
> Chunk (sidelined):
>   nr_alloc            :            4
>   max_alloc_size      :         1072
>   empty_pop_pages     :            0
>   first_bit           :            0
>   free_bytes          :       652748
>   contig_bytes        :       426720
>   sum_frag            :       426720
>   max_frag            :       426720
>   cur_min_alloc       :          156
>   cur_med_alloc       :          312
>   cur_max_alloc       :         1072
>   memcg_aware         :            1
> 
> 
 
Thank you Pratik for testing this and working with us to resolve this. I
greatly appreciate it!

Thanks,
Dennis
