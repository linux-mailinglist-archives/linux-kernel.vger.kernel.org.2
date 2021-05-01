Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1FC3708D9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 21:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhEAT5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 15:57:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32936 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231342AbhEAT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 15:57:51 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 141JuN3Q021918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 May 2021 15:56:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A3A4915C39C4; Sat,  1 May 2021 15:56:23 -0400 (EDT)
Date:   Sat, 1 May 2021 15:56:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/29] Speculative page faults (anon vmas only)
Message-ID: <YI2yZ+10MGrlFDBg@mit.edu>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eDEdRiejhCv8fIlD"
Content-Disposition: inline
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eDEdRiejhCv8fIlD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Michel,

I tried running xfstests against the spf branch, and I've noticed it's
causing regression for generic/619.  It's failing due to a umount
failure due to a busy mount point:

QA output created by 619
umount: /vdc: target is busy.

I haven't had a chance to investigate, but I thought I should let you know.q

Cheers,

					- Ted

--eDEdRiejhCv8fIlD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="619.full"

============ Test details start ============
Test name: Small-file-fallocate-test
File ratio unit: 524288
File ratio: 1
Disk saturation 0.7
Disk alloc method 1
Test iteration count: 3
Extra arg:  -f -v
/sbin/mkfs -t ext4 -F -q -b 4096 -b 4096 /dev/vdc 61440
===== Test: Small-file-fallocate-test iteration: 1 starts =====
Total available size: 209108992
Available size: 146376294.4
Thread count: 279
Testing with (279) threads
size: 524288 Bytes
Test write phase starting file /vdc/mmap-file-0 fsize 524288, id 0
Test write phase starting file /vdc/mmap-file-31 fsize 524288, id 31
Test write phase starting file /vdc/mmap-file-2 fsize 524288, id 2
Test write phase starting file /vdc/mmap-file-20 fsize 524288, id 20
Test write phase starting file /vdc/mmap-file-30 fsize 524288, id 30
Test write phase starting file /vdc/mmap-file-32 fsize 524288, id 32
Test write phase starting file /vdc/mmap-file-29 fsize 524288, id 29
Test write phase starting file /vdc/mmap-file-33 fsize 524288, id 33
Test write phase starting file /vdc/mmap-file-28 fsize 524288, id 28
Test write phase starting file /vdc/mmap-file-34 fsize 524288, id 34
Test write phase starting file /vdc/mmap-file-27 fsize 524288, id 27
Test write phase starting file /vdc/mmap-file-35 fsize 524288, id 35
Test write phase starting file /vdc/mmap-file-26 fsize 524288, id 26
Test write phase starting file /vdc/mmap-file-36 fsize 524288, id 36
Test write phase starting file /vdc/mmap-file-25 fsize 524288, id 25
Test write phase starting file /vdc/mmap-file-37 fsize 524288, id 37
Test write phase starting file /vdc/mmap-file-24 fsize 524288, id 24
Test write phase starting file /vdc/mmap-file-38 fsize 524288, id 38
Test write phase starting file /vdc/mmap-file-23 fsize 524288, id 23
Test write phase starting file /vdc/mmap-file-39 fsize 524288, id 39
Test write phase starting file /vdc/mmap-file-22 fsize 524288, id 22
Test write phase starting file /vdc/mmap-file-40 fsize 524288, id 40
Test write phase starting file /vdc/mmap-file-21 fsize 524288, id 21
Test write phase starting file /vdc/mmap-file-41 fsize 524288, id 41
Test write phase starting file /vdc/mmap-file-42 fsize 524288, id 42
Test write phase starting file /vdc/mmap-file-19 fsize 524288, id 19
Test write phase starting file /vdc/mmap-file-43 fsize 524288, id 43
Test write phase starting file /vdc/mmap-file-18 fsize 524288, id 18
Test write phase starting file /vdc/mmap-file-44 fsize 524288, id 44
Test write phase starting file /vdc/mmap-file-45 fsize 524288, id 45
Test write phase starting file /vdc/mmap-file-17 fsize 524288, id 17
Test write phase starting file /vdc/mmap-file-46 fsize 524288, id 46
Test write phase starting file /vdc/mmap-file-47 fsize 524288, id 47
Test write phase starting file /vdc/mmap-file-16 fsize 524288, id 16
Test write phase starting file /vdc/mmap-file-48 fsize 524288, id 48
Test write phase starting file /vdc/mmap-file-15 fsize 524288, id 15
Test write phase starting file /vdc/mmap-file-49 fsize 524288, id 49
Test write phase starting file /vdc/mmap-file-50 fsize 524288, id 50
Test write phase starting file /vdc/mmap-file-14 fsize 524288, id 14
Test write phase starting file /vdc/mmap-file-51 fsize 524288, id 51
Test write phase starting file /vdc/mmap-file-52 fsize 524288, id 52
Test write phase starting file /vdc/mmap-file-13 fsize 524288, id 13
Test write phase starting file /vdc/mmap-file-53 fsize 524288, id 53
Test write phase starting file /vdc/mmap-file-12 fsize 524288, id 12
Test write phase starting file /vdc/mmap-file-54 fsize 524288, id 54
Test write phase starting file /vdc/mmap-file-55 fsize 524288, id 55
Test write phase starting file /vdc/mmap-file-11 fsize 524288, id 11
Test write phase starting file /vdc/mmap-file-56 fsize 524288, id 56
Test write phase starting file /vdc/mmap-file-10 fsize 524288, id 10
Test write phase starting file /vdc/mmap-file-57 fsize 524288, id 57
Test write phase starting file /vdc/mmap-file-9 fsize 524288, id 9
Test write phase starting file /vdc/mmap-file-58 fsize 524288, id 58
Test write phase starting file /vdc/mmap-file-59 fsize 524288, id 59
Test write phase starting file /vdc/mmap-file-8 fsize 524288, id 8
Test write phase starting file /vdc/mmap-file-60 fsize 524288, id 60
Test write phase starting file /vdc/mmap-file-61 fsize 524288, id 61
Test write phase starting file /vdc/mmap-file-7 fsize 524288, id 7
Test write phase starting file /vdc/mmap-file-62 fsize 524288, id 62
Test write phase starting file /vdc/mmap-file-6 fsize 524288, id 6
Test write phase starting file /vdc/mmap-file-115 fsize 524288, id 115
Test write phase starting file /vdc/mmap-file-116 fsize 524288, id 116
Test write phase starting file /vdc/mmap-file-117 fsize 524288, id 117
Test write phase starting file /vdc/mmap-file-5 fsize 524288, id 5
Test write phase starting file /vdc/mmap-file-118 fsize 524288, id 118
Test write phase starting file /vdc/mmap-file-4 fsize 524288, id 4
Test write phase starting file /vdc/mmap-file-119 fsize 524288, id 119
Test write phase starting file /vdc/mmap-file-120 fsize 524288, id 120
Test write phase starting file /vdc/mmap-file-3 fsize 524288, id 3
Test write phase starting file /vdc/mmap-file-121 fsize 524288, id 121
Test write phase starting file /vdc/mmap-file-1 fsize 524288, id 1
Test write phase starting file /vdc/mmap-file-122 fsize 524288, id 122
Test write phase starting file /vdc/mmap-file-123 fsize 524288, id 123
Test write phase starting file /vdc/mmap-file-124 fsize 524288, id 124
Test write phase starting file /vdc/mmap-file-157 fsize 524288, id 157
Test write phase starting file /vdc/mmap-file-156 fsize 524288, id 156
Test write phase starting file /vdc/mmap-file-158 fsize 524288, id 158
Test write phase starting file /vdc/mmap-file-159 fsize 524288, id 159
Test write phase starting file /vdc/mmap-file-155 fsize 524288, id 155
Test write phase starting file /vdc/mmap-file-160 fsize 524288, id 160
Test write phase starting file /vdc/mmap-file-161 fsize 524288, id 161
Test write phase starting file /vdc/mmap-file-154 fsize 524288, id 154
Test write phase starting file /vdc/mmap-file-162 fsize 524288, id 162
Test write phase starting file /vdc/mmap-file-163 fsize 524288, id 163
Test write phase starting file /vdc/mmap-file-153 fsize 524288, id 153
Test write phase starting file /vdc/mmap-file-164 fsize 524288, id 164
Test write phase starting file /vdc/mmap-file-152 fsize 524288, id 152
Test write phase starting file /vdc/mmap-file-165 fsize 524288, id 165
Test write phase starting file /vdc/mmap-file-166 fsize 524288, id 166
Test write phase starting file /vdc/mmap-file-151 fsize 524288, id 151
Test write phase starting file /vdc/mmap-file-167 fsize 524288, id 167
Test write phase starting file /vdc/mmap-file-150 fsize 524288, id 150
Test write phase starting file /vdc/mmap-file-168 fsize 524288, id 168
Test write phase starting file /vdc/mmap-file-149 fsize 524288, id 149
Test write phase starting file /vdc/mmap-file-169 fsize 524288, id 169
Test write phase starting file /vdc/mmap-file-170 fsize 524288, id 170
Test write phase starting file /vdc/mmap-file-148 fsize 524288, id 148
Test write phase starting file /vdc/mmap-file-171 fsize 524288, id 171
Test write phase starting file /vdc/mmap-file-147 fsize 524288, id 147
Test write phase starting file /vdc/mmap-file-172 fsize 524288, id 172
Test write phase starting file /vdc/mmap-file-173 fsize 524288, id 173
Test write phase starting file /vdc/mmap-file-146 fsize 524288, id 146
Test write phase starting file /vdc/mmap-file-174 fsize 524288, id 174
Test write phase starting file /vdc/mmap-file-175 fsize 524288, id 175
Test write phase starting file /vdc/mmap-file-145 fsize 524288, id 145
Test write phase starting file /vdc/mmap-file-176 fsize 524288, id 176
Test write phase starting file /vdc/mmap-file-177 fsize 524288, id 177
Test write phase starting file /vdc/mmap-file-144 fsize 524288, id 144
Test write phase starting file /vdc/mmap-file-178 fsize 524288, id 178
Test write phase starting file /vdc/mmap-file-143 fsize 524288, id 143
Test write phase starting file /vdc/mmap-file-179 fsize 524288, id 179
Test write phase starting file /vdc/mmap-file-142 fsize 524288, id 142
Test write phase starting file /vdc/mmap-file-180 fsize 524288, id 180
Test write phase starting file /vdc/mmap-file-181 fsize 524288, id 181
Test write phase starting file /vdc/mmap-file-141 fsize 524288, id 141
Test write phase starting file /vdc/mmap-file-182 fsize 524288, id 182
Test write phase starting file /vdc/mmap-file-183 fsize 524288, id 183
Test write phase starting file /vdc/mmap-file-140 fsize 524288, id 140
Test write phase starting file /vdc/mmap-file-191 fsize 524288, id 191
Test write phase starting file /vdc/mmap-file-192 fsize 524288, id 192
Test write phase starting file /vdc/mmap-file-193 fsize 524288, id 193
Test write phase starting file /vdc/mmap-file-139 fsize 524288, id 139
Test write phase starting file /vdc/mmap-file-194 fsize 524288, id 194
Test write phase starting file /vdc/mmap-file-138 fsize 524288, id 138
Test write phase starting file /vdc/mmap-file-195 fsize 524288, id 195
Test write phase starting file /vdc/mmap-file-137 fsize 524288, id 137
Test write phase starting file /vdc/mmap-file-196 fsize 524288, id 196
Test write phase starting file /vdc/mmap-file-136 fsize 524288, id 136
Test write phase starting file /vdc/mmap-file-197 fsize 524288, id 197
Test write phase starting file /vdc/mmap-file-135 fsize 524288, id 135
Test write phase starting file /vdc/mmap-file-198 fsize 524288, id 198
Test write phase starting file /vdc/mmap-file-134 fsize 524288, id 134
Test write phase starting file /vdc/mmap-file-199 fsize 524288, id 199
Test write phase starting file /vdc/mmap-file-133 fsize 524288, id 133
Test write phase starting file /vdc/mmap-file-200 fsize 524288, id 200
Test write phase starting file /vdc/mmap-file-132 fsize 524288, id 132
Test write phase starting file /vdc/mmap-file-201 fsize 524288, id 201
Test write phase starting file /vdc/mmap-file-202 fsize 524288, id 202
Test write phase starting file /vdc/mmap-file-131 fsize 524288, id 131
Test write phase starting file /vdc/mmap-file-203 fsize 524288, id 203
Test write phase starting file /vdc/mmap-file-130 fsize 524288, id 130
Test write phase starting file /vdc/mmap-file-204 fsize 524288, id 204
Test write phase starting file /vdc/mmap-file-129 fsize 524288, id 129
Test write phase starting file /vdc/mmap-file-205 fsize 524288, id 205
Test write phase starting file /vdc/mmap-file-128 fsize 524288, id 128
Test write phase starting file /vdc/mmap-file-206 fsize 524288, id 206
Test write phase starting file /vdc/mmap-file-127 fsize 524288, id 127
Test write phase starting file /vdc/mmap-file-207 fsize 524288, id 207
Test write phase starting file /vdc/mmap-file-126 fsize 524288, id 126
Test write phase starting file /vdc/mmap-file-125 fsize 524288, id 125
Test write phase starting file /vdc/mmap-file-208 fsize 524288, id 208
Test write phase starting file /vdc/mmap-file-241 fsize 524288, id 241
Test write phase starting file /vdc/mmap-file-240 fsize 524288, id 240
Test write phase starting file /vdc/mmap-file-242 fsize 524288, id 242
Test write phase starting file /vdc/mmap-file-239 fsize 524288, id 239
Test write phase starting file /vdc/mmap-file-243 fsize 524288, id 243
Test write phase starting file /vdc/mmap-file-238 fsize 524288, id 238
Test write phase starting file /vdc/mmap-file-244 fsize 524288, id 244
Test write phase starting file /vdc/mmap-file-237 fsize 524288, id 237
Test write phase starting file /vdc/mmap-file-245 fsize 524288, id 245
Test write phase starting file /vdc/mmap-file-236 fsize 524288, id 236
Test write phase starting file /vdc/mmap-file-246 fsize 524288, id 246
Test write phase starting file /vdc/mmap-file-235 fsize 524288, id 235
Test write phase starting file /vdc/mmap-file-247 fsize 524288, id 247
Test write phase starting file /vdc/mmap-file-234 fsize 524288, id 234
Test write phase starting file /vdc/mmap-file-248 fsize 524288, id 248
Test write phase starting file /vdc/mmap-file-233 fsize 524288, id 233
Test write phase starting file /vdc/mmap-file-249 fsize 524288, id 249
Test write phase starting file /vdc/mmap-file-232 fsize 524288, id 232
Test write phase starting file /vdc/mmap-file-250 fsize 524288, id 250
Test write phase starting file /vdc/mmap-file-231 fsize 524288, id 231
Test write phase starting file /vdc/mmap-file-251 fsize 524288, id 251
Test write phase starting file /vdc/mmap-file-230 fsize 524288, id 230
Test write phase starting file /vdc/mmap-file-252 fsize 524288, id 252
Test write phase starting file /vdc/mmap-file-229 fsize 524288, id 229
Test write phase starting file /vdc/mmap-file-253 fsize 524288, id 253
Test write phase starting file /vdc/mmap-file-216 fsize 524288, id 216
Test write phase starting file /vdc/mmap-file-215 fsize 524288, id 215
Test write phase starting file /vdc/mmap-file-254 fsize 524288, id 254
Test write phase starting file /vdc/mmap-file-214 fsize 524288, id 214
Test write phase starting file /vdc/mmap-file-255 fsize 524288, id 255
Test write phase starting file /vdc/mmap-file-213 fsize 524288, id 213
Test write phase starting file /vdc/mmap-file-256 fsize 524288, id 256
Test write phase starting file /vdc/mmap-file-212 fsize 524288, id 212
Test write phase starting file /vdc/mmap-file-257 fsize 524288, id 257
Test write phase starting file /vdc/mmap-file-211 fsize 524288, id 211
Test write phase starting file /vdc/mmap-file-258 fsize 524288, id 258
Test write phase starting file /vdc/mmap-file-210 fsize 524288, id 210
Test write phase starting file /vdc/mmap-file-209 fsize 524288, id 209
Test write phase starting file /vdc/mmap-file-259 fsize 524288, id 259
Test write phase starting file /vdc/mmap-file-277 fsize 524288, id 277
Test write phase starting file /vdc/mmap-file-260 fsize 524288, id 260
Test write phase starting file /vdc/mmap-file-276 fsize 524288, id 276
Test write phase starting file /vdc/mmap-file-266 fsize 524288, id 266
Test write phase starting file /vdc/mmap-file-265 fsize 524288, id 265
Test write phase starting file /vdc/mmap-file-264 fsize 524288, id 264
Test write phase starting file /vdc/mmap-file-267 fsize 524288, id 267
Test write phase starting file /vdc/mmap-file-263 fsize 524288, id 263
Test write phase starting file /vdc/mmap-file-268 fsize 524288, id 268
Test write phase starting file /vdc/mmap-file-262 fsize 524288, id 262
Test write phase starting file /vdc/mmap-file-269 fsize 524288, id 269
Test write phase starting file /vdc/mmap-file-261 fsize 524288, id 261
Test write phase starting file /vdc/mmap-file-270 fsize 524288, id 270
Test write phase starting file /vdc/mmap-file-272 fsize 524288, id 272
Test write phase starting file /vdc/mmap-file-273 fsize 524288, id 273
Test write phase starting file /vdc/mmap-file-271 fsize 524288, id 271
Test write phase starting file /vdc/mmap-file-274 fsize 524288, id 274
Test write phase starting file /vdc/mmap-file-275 fsize 524288, id 275
Test write phase starting file /vdc/mmap-file-66 fsize 524288, id 66
Test write phase starting file /vdc/mmap-file-65 fsize 524288, id 65
Test write phase starting file /vdc/mmap-file-67 fsize 524288, id 67
Test write phase starting file /vdc/mmap-file-69 fsize 524288, id 69
Test write phase starting file /vdc/mmap-file-68 fsize 524288, id 68
Test write phase starting file /vdc/mmap-file-71 fsize 524288, id 71
Test write phase starting file /vdc/mmap-file-72 fsize 524288, id 72
Test write phase starting file /vdc/mmap-file-70 fsize 524288, id 70
Test write phase starting file /vdc/mmap-file-64 fsize 524288, id 64
Test write phase starting file /vdc/mmap-file-63 fsize 524288, id 63
Test write phase starting file /vdc/mmap-file-278 fsize 524288, id 278
Test write phase starting file /vdc/mmap-file-73 fsize 524288, id 73
Test write phase starting file /vdc/mmap-file-77 fsize 524288, id 77
Test write phase starting file /vdc/mmap-file-78 fsize 524288, id 78
Test write phase starting file /vdc/mmap-file-74 fsize 524288, id 74
Test write phase starting file /vdc/mmap-file-75 fsize 524288, id 75
Test write phase starting file /vdc/mmap-file-81 fsize 524288, id 81
Test write phase starting file /vdc/mmap-file-82 fsize 524288, id 82
Test write phase starting file /vdc/mmap-file-83 fsize 524288, id 83
Test write phase starting file /vdc/mmap-file-84 fsize 524288, id 84
Test write phase starting file /vdc/mmap-file-85 fsize 524288, id 85
Test write phase starting file /vdc/mmap-file-80 fsize 524288, id 80
Test write phase starting file /vdc/mmap-file-87 fsize 524288, id 87
Test write phase starting file /vdc/mmap-file-79 fsize 524288, id 79
Test write phase starting file /vdc/mmap-file-89 fsize 524288, id 89
Test write phase starting file /vdc/mmap-file-90 fsize 524288, id 90
Test write phase starting file /vdc/mmap-file-91 fsize 524288, id 91
Test write phase starting file /vdc/mmap-file-92 fsize 524288, id 92
Test write phase starting file /vdc/mmap-file-93 fsize 524288, id 93
Test write phase starting file /vdc/mmap-file-94 fsize 524288, id 94
Test write phase starting file /vdc/mmap-file-95 fsize 524288, id 95
Test write phase starting file /vdc/mmap-file-96 fsize 524288, id 96
Test write phase starting file /vdc/mmap-file-97 fsize 524288, id 97
Test write phase starting file /vdc/mmap-file-98 fsize 524288, id 98
Test write phase starting file /vdc/mmap-file-99 fsize 524288, id 99
Test write phase starting file /vdc/mmap-file-100 fsize 524288, id 100
Test write phase starting file /vdc/mmap-file-101 fsize 524288, id 101
Test write phase starting file /vdc/mmap-file-102 fsize 524288, id 102
Test write phase starting file /vdc/mmap-file-103 fsize 524288, id 103
Test write phase starting file /vdc/mmap-file-88 fsize 524288, id 88
Test write phase starting file /vdc/mmap-file-105 fsize 524288, id 105
Test write phase starting file /vdc/mmap-file-106 fsize 524288, id 106
Test write phase starting file /vdc/mmap-file-107 fsize 524288, id 107
Test write phase starting file /vdc/mmap-file-76 fsize 524288, id 76
Test write phase starting file /vdc/mmap-file-109 fsize 524288, id 109
Test write phase starting file /vdc/mmap-file-110 fsize 524288, id 110
Test write phase starting file /vdc/mmap-file-104 fsize 524288, id 104
Test write phase starting file /vdc/mmap-file-112 fsize 524288, id 112
Test write phase starting file /vdc/mmap-file-113 fsize 524288, id 113
Test write phase starting file /vdc/mmap-file-114 fsize 524288, id 114
Test write phase starting file /vdc/mmap-file-111 fsize 524288, id 111
Test write phase starting file /vdc/mmap-file-185 fsize 524288, id 185
Test write phase starting file /vdc/mmap-file-186 fsize 524288, id 186
Test write phase starting file /vdc/mmap-file-187 fsize 524288, id 187
Test write phase starting file /vdc/mmap-file-188 fsize 524288, id 188
Test write phase starting file /vdc/mmap-file-189 fsize 524288, id 189
Test write phase starting file /vdc/mmap-file-190 fsize 524288, id 190
Test write phase starting file /vdc/mmap-file-184 fsize 524288, id 184
Test write phase starting file /vdc/mmap-file-86 fsize 524288, id 86
Test write phase starting file /vdc/mmap-file-108 fsize 524288, id 108
Test write phase starting file /vdc/mmap-file-228 fsize 524288, id 228
Test write phase starting file /vdc/mmap-file-227 fsize 524288, id 227
Test write phase starting file /vdc/mmap-file-226 fsize 524288, id 226
Test write phase starting file /vdc/mmap-file-225 fsize 524288, id 225
Test write phase starting file /vdc/mmap-file-224 fsize 524288, id 224
Test write phase starting file /vdc/mmap-file-223 fsize 524288, id 223
Test write phase starting file /vdc/mmap-file-222 fsize 524288, id 222
Test write phase starting file /vdc/mmap-file-221 fsize 524288, id 221
Test write phase starting file /vdc/mmap-file-220 fsize 524288, id 220
Test write phase starting file /vdc/mmap-file-219 fsize 524288, id 219
Test write phase starting file /vdc/mmap-file-218 fsize 524288, id 218
Test write phase starting file /vdc/mmap-file-217 fsize 524288, id 217
Test write phase completed...file /vdc/mmap-file-0, fsize 524288, id 0
Test write phase completed...file /vdc/mmap-file-14, fsize 524288, id 14
Test write phase completed...file /vdc/mmap-file-11, fsize 524288, id 11
Test write phase completed...file /vdc/mmap-file-59, fsize 524288, id 59
Test write phase completed...file /vdc/mmap-file-160, fsize 524288, id 160
Test write phase completed...file /vdc/mmap-file-20, fsize 524288, id 20
Test write phase completed...file /vdc/mmap-file-37, fsize 524288, id 37
Test write phase completed...file /vdc/mmap-file-39, fsize 524288, id 39
Test write phase completed...file /vdc/mmap-file-21, fsize 524288, id 21
Test write phase completed...file /vdc/mmap-file-45, fsize 524288, id 45
Test write phase completed...file /vdc/mmap-file-50, fsize 524288, id 50
Test write phase completed...file /vdc/mmap-file-121, fsize 524288, id 121
Test write phase completed...file /vdc/mmap-file-158, fsize 524288, id 158
Test write phase completed...file /vdc/mmap-file-156, fsize 524288, id 156
Test write phase completed...file /vdc/mmap-file-219, fsize 524288, id 219
Test write phase completed...file /vdc/mmap-file-151, fsize 524288, id 151
Test write phase completed...file /vdc/mmap-file-150, fsize 524288, id 150
Test write phase completed...file /vdc/mmap-file-223, fsize 524288, id 223
Test write phase completed...file /vdc/mmap-file-171, fsize 524288, id 171
Test write phase completed...file /vdc/mmap-file-227, fsize 524288, id 227
Test write phase completed...file /vdc/mmap-file-146, fsize 524288, id 146
Test write phase completed...file /vdc/mmap-file-277, fsize 524288, id 277
Test write phase completed...file /vdc/mmap-file-265, fsize 524288, id 265
Test write phase completed...file /vdc/mmap-file-41, fsize 524288, id 41
Test write phase completed...file /vdc/mmap-file-63, fsize 524288, id 63
Test write phase completed...file /vdc/mmap-file-222, fsize 524288, id 222
Test write phase completed...file /vdc/mmap-file-64, fsize 524288, id 64
Test write phase completed...file /vdc/mmap-file-114, fsize 524288, id 114
Test write phase completed...file /vdc/mmap-file-30, fsize 524288, id 30
Test write phase completed...file /vdc/mmap-file-1, fsize 524288, id 1
Test write phase completed...file /vdc/mmap-file-95, fsize 524288, id 95
Test write phase completed...file /vdc/mmap-file-202, fsize 524288, id 202
Test write phase completed...file /vdc/mmap-file-87, fsize 524288, id 87
Test write phase completed...file /vdc/mmap-file-259, fsize 524288, id 259
Test write phase completed...file /vdc/mmap-file-214, fsize 524288, id 214
Test write phase completed...file /vdc/mmap-file-187, fsize 524288, id 187
Test write phase completed...file /vdc/mmap-file-273, fsize 524288, id 273
Test write phase completed...file /vdc/mmap-file-217, fsize 524288, id 217
Test write phase completed...file /vdc/mmap-file-197, fsize 524288, id 197
Test write phase completed...file /vdc/mmap-file-110, fsize 524288, id 110
Test write phase completed...file /vdc/mmap-file-85, fsize 524288, id 85
Test write phase completed...file /vdc/mmap-file-93, fsize 524288, id 93
Test write phase completed...file /vdc/mmap-file-48, fsize 524288, id 48
Test write phase completed...file /vdc/mmap-file-218, fsize 524288, id 218
Test write phase completed...file /vdc/mmap-file-7, fsize 524288, id 7
Test write phase completed...file /vdc/mmap-file-239, fsize 524288, id 239
Test write phase completed...file /vdc/mmap-file-206, fsize 524288, id 206
Test write phase completed...file /vdc/mmap-file-170, fsize 524288, id 170
Test write phase completed...file /vdc/mmap-file-168, fsize 524288, id 168
Test write phase completed...file /vdc/mmap-file-17, fsize 524288, id 17
Test write phase completed...file /vdc/mmap-file-167, fsize 524288, id 167
Test write phase completed...file /vdc/mmap-file-18, fsize 524288, id 18
Test write phase completed...file /vdc/mmap-file-172, fsize 524288, id 172
Test write phase completed...file /vdc/mmap-file-268, fsize 524288, id 268
Test write phase completed...file /vdc/mmap-file-25, fsize 524288, id 25
Test write phase completed...file /vdc/mmap-file-15, fsize 524288, id 15
Test write phase completed...file /vdc/mmap-file-208, fsize 524288, id 208
Test write phase completed...file /vdc/mmap-file-189, fsize 524288, id 189
Test write phase completed...file /vdc/mmap-file-255, fsize 524288, id 255
Test write phase completed...file /vdc/mmap-file-97, fsize 524288, id 97
Test write phase completed...file /vdc/mmap-file-174, fsize 524288, id 174
Test write phase completed...file /vdc/mmap-file-124, fsize 524288, id 124
Test write phase completed...file /vdc/mmap-file-109, fsize 524288, id 109
Test write phase completed...file /vdc/mmap-file-3, fsize 524288, id 3
Test write phase completed...file /vdc/mmap-file-200, fsize 524288, id 200
Test write phase completed...file /vdc/mmap-file-23, fsize 524288, id 23
Test write phase completed...file /vdc/mmap-file-135, fsize 524288, id 135
Test write phase completed...file /vdc/mmap-file-181, fsize 524288, id 181
Test write phase completed...file /vdc/mmap-file-157, fsize 524288, id 157
Test write phase completed...file /vdc/mmap-file-153, fsize 524288, id 153
Test write phase completed...file /vdc/mmap-file-225, fsize 524288, id 225
Test write phase completed...file /vdc/mmap-file-105, fsize 524288, id 105
Test write phase completed...file /vdc/mmap-file-147, fsize 524288, id 147
Test write phase completed...file /vdc/mmap-file-184, fsize 524288, id 184
Test write phase completed...file /vdc/mmap-file-221, fsize 524288, id 221
Test write phase completed...file /vdc/mmap-file-224, fsize 524288, id 224
Test write phase completed...file /vdc/mmap-file-67, fsize 524288, id 67
Test write phase completed...file /vdc/mmap-file-178, fsize 524288, id 178
Test write phase completed...file /vdc/mmap-file-16, fsize 524288, id 16
Test write phase completed...file /vdc/mmap-file-250, fsize 524288, id 250
Test write phase completed...file /vdc/mmap-file-49, fsize 524288, id 49
Test write phase completed...file /vdc/mmap-file-247, fsize 524288, id 247
Test write phase completed...file /vdc/mmap-file-196, fsize 524288, id 196
Test write phase completed...file /vdc/mmap-file-209, fsize 524288, id 209
Test write phase completed...file /vdc/mmap-file-203, fsize 524288, id 203
Test write phase completed...file /vdc/mmap-file-29, fsize 524288, id 29
Test write phase completed...file /vdc/mmap-file-82, fsize 524288, id 82
Test write phase completed...file /vdc/mmap-file-262, fsize 524288, id 262
Test write phase completed...file /vdc/mmap-file-66, fsize 524288, id 66
Test write phase completed...file /vdc/mmap-file-42, fsize 524288, id 42
Test write phase completed...file /vdc/mmap-file-62, fsize 524288, id 62
Test write phase completed...file /vdc/mmap-file-120, fsize 524288, id 120
Test write phase completed...file /vdc/mmap-file-122, fsize 524288, id 122
Test write phase completed...file /vdc/mmap-file-27, fsize 524288, id 27
Test write phase completed...file /vdc/mmap-file-163, fsize 524288, id 163
Test write phase completed...file /vdc/mmap-file-161, fsize 524288, id 161
Test write phase completed...file /vdc/mmap-file-83, fsize 524288, id 83
Test write phase completed...file /vdc/mmap-file-126, fsize 524288, id 126
Test write phase completed...file /vdc/mmap-file-211, fsize 524288, id 211
Test write phase completed...file /vdc/mmap-file-131, fsize 524288, id 131
Test write phase completed...file /vdc/mmap-file-38, fsize 524288, id 38
Test write phase completed...file /vdc/mmap-file-74, fsize 524288, id 74
Test write phase completed...file /vdc/mmap-file-190, fsize 524288, id 190
Test write phase completed...file /vdc/mmap-file-55, fsize 524288, id 55
Test write phase completed...file /vdc/mmap-file-103, fsize 524288, id 103
Test write phase completed...file /vdc/mmap-file-248, fsize 524288, id 248
Test write phase completed...file /vdc/mmap-file-96, fsize 524288, id 96
Test write phase completed...file /vdc/mmap-file-35, fsize 524288, id 35
Test write phase completed...file /vdc/mmap-file-118, fsize 524288, id 118
Test write phase completed...file /vdc/mmap-file-70, fsize 524288, id 70
Test write phase completed...file /vdc/mmap-file-57, fsize 524288, id 57
Test write phase completed...file /vdc/mmap-file-13, fsize 524288, id 13
Test write phase completed...file /vdc/mmap-file-56, fsize 524288, id 56
Test write phase completed...file /vdc/mmap-file-154, fsize 524288, id 154
Test write phase completed...file /vdc/mmap-file-186, fsize 524288, id 186
Test write phase completed...file /vdc/mmap-file-232, fsize 524288, id 232
Test write phase completed...file /vdc/mmap-file-136, fsize 524288, id 136
Test write phase completed...file /vdc/mmap-file-80, fsize 524288, id 80
Test write phase completed...file /vdc/mmap-file-201, fsize 524288, id 201
Test write phase completed...file /vdc/mmap-file-28, fsize 524288, id 28
Test write phase completed...file /vdc/mmap-file-139, fsize 524288, id 139
Test write phase completed...file /vdc/mmap-file-226, fsize 524288, id 226
Test write phase completed...file /vdc/mmap-file-266, fsize 524288, id 266
Test write phase completed...file /vdc/mmap-file-36, fsize 524288, id 36
Test write phase completed...file /vdc/mmap-file-228, fsize 524288, id 228
Test write phase completed...file /vdc/mmap-file-94, fsize 524288, id 94
Test write phase completed...file /vdc/mmap-file-127, fsize 524288, id 127
Test write phase completed...file /vdc/mmap-file-86, fsize 524288, id 86
Test write phase completed...file /vdc/mmap-file-140, fsize 524288, id 140
Test write phase completed...file /vdc/mmap-file-243, fsize 524288, id 243
Test write phase completed...file /vdc/mmap-file-173, fsize 524288, id 173
Test write phase completed...file /vdc/mmap-file-220, fsize 524288, id 220
Test write phase completed...file /vdc/mmap-file-237, fsize 524288, id 237
Test write phase completed...file /vdc/mmap-file-207, fsize 524288, id 207
Test write phase completed...file /vdc/mmap-file-81, fsize 524288, id 81
Test write phase completed...file /vdc/mmap-file-8, fsize 524288, id 8
Test write phase completed...file /vdc/mmap-file-91, fsize 524288, id 91
Test write phase completed...file /vdc/mmap-file-185, fsize 524288, id 185
Test write phase completed...file /vdc/mmap-file-40, fsize 524288, id 40
Test write phase completed...file /vdc/mmap-file-100, fsize 524288, id 100
Test write phase completed...file /vdc/mmap-file-252, fsize 524288, id 252
Test write phase completed...file /vdc/mmap-file-99, fsize 524288, id 99
Test write phase completed...file /vdc/mmap-file-142, fsize 524288, id 142
Test write phase completed...file /vdc/mmap-file-235, fsize 524288, id 235
Test write phase completed...file /vdc/mmap-file-5, fsize 524288, id 5
Test write phase completed...file /vdc/mmap-file-101, fsize 524288, id 101
Test write phase completed...file /vdc/mmap-file-115, fsize 524288, id 115
Test write phase completed...file /vdc/mmap-file-234, fsize 524288, id 234
Test write phase completed...file /vdc/mmap-file-267, fsize 524288, id 267
Test write phase completed...file /vdc/mmap-file-198, fsize 524288, id 198
Test write phase completed...file /vdc/mmap-file-270, fsize 524288, id 270
Test write phase completed...file /vdc/mmap-file-128, fsize 524288, id 128
Test write phase completed...file /vdc/mmap-file-164, fsize 524288, id 164
Test write phase completed...file /vdc/mmap-file-182, fsize 524288, id 182
Test write phase completed...file /vdc/mmap-file-271, fsize 524288, id 271
Test write phase completed...file /vdc/mmap-file-58, fsize 524288, id 58
Test write phase completed...file /vdc/mmap-file-68, fsize 524288, id 68
Test write phase completed...file /vdc/mmap-file-116, fsize 524288, id 116
Test write phase completed...file /vdc/mmap-file-104, fsize 524288, id 104
Test write phase completed...file /vdc/mmap-file-149, fsize 524288, id 149
Test write phase completed...file /vdc/mmap-file-256, fsize 524288, id 256
Test write phase completed...file /vdc/mmap-file-52, fsize 524288, id 52
Test write phase completed...file /vdc/mmap-file-183, fsize 524288, id 183
Test write phase completed...file /vdc/mmap-file-233, fsize 524288, id 233
Test write phase completed...file /vdc/mmap-file-92, fsize 524288, id 92
Test write phase completed...file /vdc/mmap-file-33, fsize 524288, id 33
Test write phase completed...file /vdc/mmap-file-31, fsize 524288, id 31
Test write phase completed...file /vdc/mmap-file-244, fsize 524288, id 244
Test write phase completed...file /vdc/mmap-file-137, fsize 524288, id 137
Test write phase completed...file /vdc/mmap-file-152, fsize 524288, id 152
Test write phase completed...file /vdc/mmap-file-132, fsize 524288, id 132
Test write phase completed...file /vdc/mmap-file-43, fsize 524288, id 43
Test write phase completed...file /vdc/mmap-file-216, fsize 524288, id 216
Test write phase completed...file /vdc/mmap-file-236, fsize 524288, id 236
Test write phase completed...file /vdc/mmap-file-72, fsize 524288, id 72
Test write phase completed...file /vdc/mmap-file-123, fsize 524288, id 123
Test write phase completed...file /vdc/mmap-file-54, fsize 524288, id 54
Test write phase completed...file /vdc/mmap-file-213, fsize 524288, id 213
Test write phase completed...file /vdc/mmap-file-272, fsize 524288, id 272
Test write phase completed...file /vdc/mmap-file-134, fsize 524288, id 134
Test write phase completed...file /vdc/mmap-file-238, fsize 524288, id 238
Test write phase completed...file /vdc/mmap-file-106, fsize 524288, id 106
Test write phase completed...file /vdc/mmap-file-269, fsize 524288, id 269
Test write phase completed...file /vdc/mmap-file-143, fsize 524288, id 143
Test write phase completed...file /vdc/mmap-file-193, fsize 524288, id 193
Test write phase completed...file /vdc/mmap-file-102, fsize 524288, id 102
Test write phase completed...file /vdc/mmap-file-108, fsize 524288, id 108
Test write phase completed...file /vdc/mmap-file-275, fsize 524288, id 275
Test write phase completed...file /vdc/mmap-file-215, fsize 524288, id 215
Test write phase completed...file /vdc/mmap-file-261, fsize 524288, id 261
Test write phase completed...file /vdc/mmap-file-53, fsize 524288, id 53
Test write phase completed...file /vdc/mmap-file-241, fsize 524288, id 241
Test write phase completed...file /vdc/mmap-file-19, fsize 524288, id 19
Test write phase completed...file /vdc/mmap-file-175, fsize 524288, id 175
Test write phase completed...file /vdc/mmap-file-166, fsize 524288, id 166
Test write phase completed...file /vdc/mmap-file-188, fsize 524288, id 188
Test write phase completed...file /vdc/mmap-file-111, fsize 524288, id 111
Test write phase completed...file /vdc/mmap-file-278, fsize 524288, id 278
Test write phase completed...file /vdc/mmap-file-274, fsize 524288, id 274
Test write phase completed...file /vdc/mmap-file-204, fsize 524288, id 204
Test write phase completed...file /vdc/mmap-file-254, fsize 524288, id 254
Test write phase completed...file /vdc/mmap-file-51, fsize 524288, id 51
Test write phase completed...file /vdc/mmap-file-176, fsize 524288, id 176
Test write phase completed...file /vdc/mmap-file-195, fsize 524288, id 195
Test write phase completed...file /vdc/mmap-file-145, fsize 524288, id 145
Test write phase completed...file /vdc/mmap-file-76, fsize 524288, id 76
Test write phase completed...file /vdc/mmap-file-22, fsize 524288, id 22
Test write phase completed...file /vdc/mmap-file-230, fsize 524288, id 230
Test write phase completed...file /vdc/mmap-file-44, fsize 524288, id 44
Test write phase completed...file /vdc/mmap-file-2, fsize 524288, id 2
Test write phase completed...file /vdc/mmap-file-180, fsize 524288, id 180
Test write phase completed...file /vdc/mmap-file-4, fsize 524288, id 4
Test write phase completed...file /vdc/mmap-file-60, fsize 524288, id 60
Test write phase completed...file /vdc/mmap-file-192, fsize 524288, id 192
Test write phase completed...file /vdc/mmap-file-130, fsize 524288, id 130
Test write phase completed...file /vdc/mmap-file-191, fsize 524288, id 191
Test write phase completed...file /vdc/mmap-file-125, fsize 524288, id 125
Test write phase completed...file /vdc/mmap-file-79, fsize 524288, id 79
Test write phase completed...file /vdc/mmap-file-119, fsize 524288, id 119
Test write phase completed...file /vdc/mmap-file-263, fsize 524288, id 263
Test write phase completed...file /vdc/mmap-file-231, fsize 524288, id 231
Test write phase completed...file /vdc/mmap-file-205, fsize 524288, id 205
Test write phase completed...file /vdc/mmap-file-34, fsize 524288, id 34
Test write phase completed...file /vdc/mmap-file-88, fsize 524288, id 88
Test write phase completed...file /vdc/mmap-file-159, fsize 524288, id 159
Test write phase completed...file /vdc/mmap-file-73, fsize 524288, id 73
Test write phase completed...file /vdc/mmap-file-47, fsize 524288, id 47
Test write phase completed...file /vdc/mmap-file-251, fsize 524288, id 251
Test write phase completed...file /vdc/mmap-file-253, fsize 524288, id 253
Test write phase completed...file /vdc/mmap-file-210, fsize 524288, id 210
Test write phase completed...file /vdc/mmap-file-162, fsize 524288, id 162
Test write phase completed...file /vdc/mmap-file-26, fsize 524288, id 26
Test write phase completed...file /vdc/mmap-file-260, fsize 524288, id 260
Test write phase completed...file /vdc/mmap-file-199, fsize 524288, id 199
Test write phase completed...file /vdc/mmap-file-138, fsize 524288, id 138
Test write phase completed...file /vdc/mmap-file-107, fsize 524288, id 107
Test write phase completed...file /vdc/mmap-file-246, fsize 524288, id 246
Test write phase completed...file /vdc/mmap-file-129, fsize 524288, id 129
Test write phase completed...file /vdc/mmap-file-71, fsize 524288, id 71
Test write phase completed...file /vdc/mmap-file-258, fsize 524288, id 258
Test write phase completed...file /vdc/mmap-file-46, fsize 524288, id 46
Test write phase completed...file /vdc/mmap-file-24, fsize 524288, id 24
Test write phase completed...file /vdc/mmap-file-242, fsize 524288, id 242
Test write phase completed...file /vdc/mmap-file-133, fsize 524288, id 133
Test write phase completed...file /vdc/mmap-file-78, fsize 524288, id 78
Test write phase completed...file /vdc/mmap-file-9, fsize 524288, id 9
Test write phase completed...file /vdc/mmap-file-264, fsize 524288, id 264
Test write phase completed...file /vdc/mmap-file-165, fsize 524288, id 165
Test write phase completed...file /vdc/mmap-file-12, fsize 524288, id 12
Test write phase completed...file /vdc/mmap-file-212, fsize 524288, id 212
Test write phase completed...file /vdc/mmap-file-229, fsize 524288, id 229
Test write phase completed...file /vdc/mmap-file-98, fsize 524288, id 98
Test write phase completed...file /vdc/mmap-file-10, fsize 524288, id 10
Test write phase completed...file /vdc/mmap-file-61, fsize 524288, id 61
Test write phase completed...file /vdc/mmap-file-249, fsize 524288, id 249
Test write phase completed...file /vdc/mmap-file-6, fsize 524288, id 6
Test write phase completed...file /vdc/mmap-file-77, fsize 524288, id 77
Test write phase completed...file /vdc/mmap-file-65, fsize 524288, id 65
Test write phase completed...file /vdc/mmap-file-155, fsize 524288, id 155
Test write phase completed...file /vdc/mmap-file-148, fsize 524288, id 148
Test write phase completed...file /vdc/mmap-file-90, fsize 524288, id 90
Test write phase completed...file /vdc/mmap-file-144, fsize 524288, id 144
Test write phase completed...file /vdc/mmap-file-117, fsize 524288, id 117
Test write phase completed...file /vdc/mmap-file-112, fsize 524288, id 112
Test write phase completed...file /vdc/mmap-file-69, fsize 524288, id 69
Test write phase completed...file /vdc/mmap-file-89, fsize 524288, id 89
Test write phase completed...file /vdc/mmap-file-257, fsize 524288, id 257
Test write phase completed...file /vdc/mmap-file-75, fsize 524288, id 75
Test write phase completed...file /vdc/mmap-file-177, fsize 524288, id 177
Test write phase completed...file /vdc/mmap-file-194, fsize 524288, id 194
Test write phase completed...file /vdc/mmap-file-84, fsize 524288, id 84
Test write phase completed...file /vdc/mmap-file-141, fsize 524288, id 141
Test write phase completed...file /vdc/mmap-file-240, fsize 524288, id 240
Test write phase completed...file /vdc/mmap-file-245, fsize 524288, id 245
Test write phase completed...file /vdc/mmap-file-169, fsize 524288, id 169
Test write phase completed...file /vdc/mmap-file-32, fsize 524288, id 32
Test write phase completed...file /vdc/mmap-file-113, fsize 524288, id 113
Test write phase completed...file /vdc/mmap-file-276, fsize 524288, id 276
Test write phase completed...file /vdc/mmap-file-179, fsize 524288, id 179
===== Test: Small-file-fallocate-test iteration: 1 ends =====
/sbin/mkfs -t ext4 -F -q -b 4096 -b 4096 /dev/vdc 61440
/dev/vdc is mounted; will not make a filesystem here!
/sbin/mkfs.ext4 failed!

--eDEdRiejhCv8fIlD--
